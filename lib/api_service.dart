import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      var baseUrl = 'https://digimon-api.vercel.app/api/digimon';
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Gagal mengambil data dari server');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
