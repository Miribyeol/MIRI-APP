import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pet_input_model.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> registerPetInfo({
  required String name,
  required String species,
  required String birthday,
  required String deathday,
  String? filename,
}) async {
  try {
    String? storedToken = await _storage.read(key: 'jwt_token');

    if (storedToken == null) {
      print('저장된 토큰 없음');
      return {'success': false, 'error': 'Token not found'};
    }

    var apiUrl = dotenv.env['API_URL'];
    var registerUrl = Uri.parse('$apiUrl/pet');
    var petInfo = PetInput(
      name: name,
      species: species,
      birthday: birthday,
      deathday: deathday,
      image: filename, 
    );

    var registerResponse = await http.post(
      registerUrl,
      headers: {
        'Authorization': 'Bearer $storedToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(petInfo.toJson()),
    );

    if (registerResponse.statusCode == 201) {
      print('반려동물 정보 등록 성공');
      return {'success': true};
    } else {
      print('반려동물 정보 등록 실패: ${registerResponse.statusCode}');
      return {'success': false, 'error': 'Failed to register pet info'};
    }
  } catch (error) {
    print('반려동물 정보 등록 오류: $error');
    return {'success': false, 'error': error.toString()};
  }
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
