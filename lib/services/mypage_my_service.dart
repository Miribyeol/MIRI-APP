import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user_info_model.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchUserNickname() async {
    try {
      String? storedToken = await const FlutterSecureStorage().read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/user/nickname');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var userNicknameData = UserNickname.fromJson(jsonResponse);
          var userNickname = userNicknameData.result?.nickname;
          return {'success': true, 'nickname': userNickname};
        } else {
          return {'success': false, 'error': 'Failed to fetch user nickname'};
        }
      } else {
        return {'success': false, 'error': 'Token not found'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'Error fetching user nickname: $error'
      };
    }
  }

  Future<Map<String, dynamic>> updateUserNickname(String newNickname) async {
    try {
      String? storedToken = await const FlutterSecureStorage().read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/user/nickname');
        var response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'nickname': newNickname}),
        );

        if (response.statusCode == 200) {
          return {'success': true};
        } else {
          return {'success': false, 'error': 'Failed to update user nickname'};
        }
      } else {
        return {'success': false, 'error': 'Token not found'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'Error updating user nickname: $error'
      };
    }
  }
}
