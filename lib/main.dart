import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digimon App',
      home: DigimonApp(),
    ),
  );
}

class DigimonApp extends StatefulWidget {
  const DigimonApp({Key? key}) : super(key: key);

  @override
  _DigimonAppState createState() => _DigimonAppState();
}

class _DigimonAppState extends State<DigimonApp> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digimon App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Sesuaikan path gambar
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: apiService.getData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var list = snapshot.data as List;
              return Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: Hero(
                            tag: 'digimon_image_$index',
                            child: Image.network(
                              list[index]['img'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            list[index]['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            list[index]['level'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            _navigateToDetail(context, list[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Map<String, dynamic> digimon) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DigimonDetailScreen(digimon: digimon),
      ),
    );
  }
}

class DigimonDetailScreen extends StatelessWidget {
  final Map<String, dynamic> digimon;

  DigimonDetailScreen({required this.digimon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(digimon['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'digimon_image_${digimon['name']}',
              child: Image.network(
                digimon['img'],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Level: ${digimon['level']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
