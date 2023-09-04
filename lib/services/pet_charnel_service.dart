import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, String?>> fetchPetInfo() async {
  try {
    String? storedToken = await _storage.read(key: 'jwt_token');
    if (storedToken != null) {
      var apiUrl = dotenv.env['API_URL'];
      var url = Uri.parse('$apiUrl/pet');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $storedToken',
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('JSON Response: $jsonResponse');
        return {
          'petName': jsonResponse['result']['petInfo']['name'],
          'petBirthDate': jsonResponse['result']['petInfo']['birthday'],
          'petDeathDate': jsonResponse['result']['petInfo']['deathday'],
          'petImage': jsonResponse['result']['petInfo']['image'],
        };
      } else {
        print('Failed to fetch pet info: ${response.statusCode}');
      }
    }
  } catch (error) {
    print('Error fetching pet info: $error');
  }
  return {
    'petName': null,
    'petBirthDate': null,
    'petDeathDate': null,
    'petImage': null,
  };
}

}
