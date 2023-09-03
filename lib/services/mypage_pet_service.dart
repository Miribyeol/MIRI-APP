import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pet_info_model.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchPetInfo() async {
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
            'success': true,
            'petInfo': PetInfo.fromJson(jsonResponse['result']['petInfo']),
          };
        } else {
          print('Failed to fetch pet info: ${response.statusCode}');
          return {
            'success': false,
            'error': 'Failed to fetch pet info: ${response.statusCode}',
          };
        }
      }
    } catch (error) {
      print('Error fetching pet info: $error');
      return {
        'success': false,
        'error': 'Error fetching pet info: $error',
      };
    }

    return {
      'success': false,
      'error': 'Unknown error occurred while fetching pet info.',
    };
  }

  Future<Map<String, dynamic>> updatePetInfo(PetInfo petInfo) async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/pet');
        var response = await http.put(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(petInfo.toJson()),
        );

        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          print('Update Response: $jsonResponse');
          return {
            'success': true,
            'petInfo': PetInfo.fromJson(jsonResponse['result']['petInfo']),
          };
        } else {
          print('Failed to update pet info: ${response.statusCode}');
          return {
            'success': false,
            'error': 'Failed to update pet info: ${response.statusCode}',
          };
        }
      }
    } catch (error) {
      print('Error updating pet info: $error');
      return {
        'success': false,
        'error': 'Error updating pet info: $error',
      };
    }

    return {
      'success': false,
      'error': 'Unknown error occurred while updating pet info.',
    };
  }
}
