import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pet_input_model.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> registerPetInfo({
    required String name,
    required String species,
    required String birthday,
    required String deathday,
  }) async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/pet');
        var petInfo = PetInput(
          name: name,
          species: species,
          birthday: birthday,
          deathday: deathday,
        );

        var response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(petInfo.toJson()),
        );

        if (response.statusCode == 201) {
          print('반려동물 정보 등록 성공');
        } else {
          print('반려동물 정보 등록 실패: ${response.statusCode}');
        }
      } else {
        print('저장된 토큰 없음');
      }
    } catch (error) {
      print('반려동물 정보 등록 오류: $error');
    }
  }
}
