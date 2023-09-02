import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> fetchDataFromServer() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL']; // Get API address from .env

        var url = Uri.parse('$apiUrl/main'); // Use the API address
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          print('Failed to fetch data from server: ${response.statusCode}');
          return null;
        }
      }
    } catch (error) {
      print('Error fetching data from server: $error');
      return null;
    }
  }
}
