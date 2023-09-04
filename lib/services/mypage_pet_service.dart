import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pet_info_model.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

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

  Future<Map<String, dynamic>> updatePetInfo(PetInfo petInfo, File? imageFile) async {
  try {
    String? storedToken = await _storage.read(key: 'jwt_token');
    if (storedToken != null) {
      var apiUrl = dotenv.env['API_URL'];

      String? uploadedFilename;
      if (imageFile != null) {
        var uploadResult = await uploadPetImage(imageFile);
        if (!uploadResult['success']) {
          print('이미지 업로드 실패: ${uploadResult['error']}');
          return {'success': false, 'error': 'Failed to upload image'};
        }
        uploadedFilename = uploadResult['filename'];
      }

      petInfo.image = uploadedFilename ?? petInfo.image; 

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

Future<Map<String, dynamic>> uploadPetImage(File image) async {
  String? storedToken = await _storage.read(key: 'jwt_token');
  if (storedToken == null) {
    print('저장된 토큰 없음');
    return {'success': false, 'error': 'Token not found'};
  }

  var apiUrl = dotenv.env['API_URL'];
  var uploadUrl = Uri.parse('$apiUrl/pet/image');
  var request = http.MultipartRequest('POST', uploadUrl)
    ..headers['Authorization'] = 'Bearer $storedToken'
    ..files.add(await http.MultipartFile.fromPath(
      'img',
      image.path,
      contentType: MediaType('image', 'png'),
    ));

  try {
    var uploadResponse = await request.send();
    String responseBody = await uploadResponse.stream.bytesToString();
    Map<String, dynamic> responseJson = jsonDecode(responseBody);

    if (uploadResponse.statusCode == 201) {
      print('이미지 업로드 성공: ${responseJson['result']['filename']}');
      return {'success': true, 'filename': responseJson['result']['filename']};
    } else {
      print('서버 응답: $responseBody');
      return {'success': false, 'error': responseBody};
    }
  } catch (error) {
    print('이미지 업로드 오류: $error');
    return {'success': false, 'error': error.toString()};
  }
}

}
