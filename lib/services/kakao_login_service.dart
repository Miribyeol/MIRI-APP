import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KakaoLoginService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _sendToken(dynamic token) async {
    var apiUrl = dotenv.env['API_URL'] ?? '';
    var url = Uri.parse('$apiUrl/auth/login');
    var body = jsonEncode(token);

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if ([200, 201].contains(response.statusCode)) {
        var data = jsonDecode(response.body)["result"]["token"];
        await _storage.write(key: 'jwt_token', value: data);
        print('JWT 토큰 저장 완료');
      } else {
        print('서버 응답 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('사용자 토큰 요청 실패: $error');
    }
  }

  Future<OAuthToken?> _performKakaoLogin(BuildContext context) async {
    try {
      return await isKakaoTalkInstalled()
          ? UserApi.instance.loginWithKakaoTalk()
          : UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      print('카카오 로그인 실패: $error');
      Navigator.pushReplacementNamed(context, '/login');
      return null;
    }
  }

  Future<void> _checkPetRegistration(BuildContext context) async {
    final storedToken = await _storage.read(key: 'jwt_token');

    if (storedToken == null) return;
    print('1차 Stored Token: $storedToken');

    var apiUrl = dotenv.env['API_URL'] ?? '';
    var url = Uri.parse('$apiUrl/pet/check');
    print('2차 Stored Token: $storedToken');

    try {
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $storedToken',
      });
      print('3차 Stored Token: $storedToken');

      var responseData = jsonDecode(response.body);
      print('4차 Stored Token: $storedToken');
      if (response.statusCode == 200) {
        var action = responseData['success'] ? '/start' : '/pet_info_input';
        Navigator.pushReplacementNamed(context, action);
        print(responseData['success']
            ? '반려동물 정보가 등록되어 있습니다.'
            : '반려동물 정보가 등록되어 있지 않습니다.');
      } else if (response.statusCode == 401) {
        // Redirect the user to the login page when status code is 401
        print('1차 반려동물 정보 등록 확인 실패: ${response.statusCode}');
        Navigator.pushReplacementNamed(context, '/pet_info_input');
      } else {
        print('2차 반려동물 정보 등록 확인 실패: ${response.statusCode}');
        Navigator.pushReplacementNamed(context, '/pet_info_input');
      }
    } catch (error) {
      print('3차 반려동물 정보 등록 확인 실패: $error');
    }
  }

  Future<bool> kakaoLogin(BuildContext context) async {
    OAuthToken? token = await _performKakaoLogin(context);
    if (token == null) return false;

    await _sendToken(token);
    await _checkPetRegistration(context);
    return true;
  }

  Future<void> kakaoLogout() async {
    try {
      await UserApi.instance.logout();
      print('Logged out from Kakao');
    } catch (error) {
      print('Logout error: $error');
    }
  }

  Future<void> autoLogin(BuildContext context) async {
    final storedToken = await _storage.read(key: 'jwt_token');

    if (storedToken == null) return;

    var apiUrl = dotenv.env['API_URL'] ?? '';
    var url = Uri.parse('$apiUrl/auth/check');

    try {
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $storedToken',
      });

      if (response.statusCode == 200) {
        await _checkPetRegistration(context);
      } else {
        print('1차 토큰 검증 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('2차 토큰 검증 실패: $error');
    }
  }
}

class AuthHelper {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> checkKakaoLoginStatus() async {
    return await _storage.read(key: 'jwt_token') != null;
  }
}
