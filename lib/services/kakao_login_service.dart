import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KakaoLoginService {
  // final String serverUrl = 'http://192.168.200.192:3000/auth';
  final _storage = const FlutterSecureStorage();

  Future<void> sendToken(dynamic token) async {
    try {
      print('사용자 토큰 요청 성공\n토큰: $token');
      var apiUrl = dotenv.env['API_URL'];
      var url = Uri.parse('$apiUrl/auth/login');
      var body = jsonEncode(token);
      var response = await http.post(url,
          headers: {
            // 'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
          body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('서버 응답 성공: ${response.body}');
        var data = jsonDecode(response.body)["result"]["token"];
        await _storage.write(key: 'jwt_token', value: data);
        print('JWT 토큰 저장 완료');
      } else {
        print('서버 응답 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('사용자 토큰 요청 실패 $error');
    }
  }

  Future<OAuthToken?> performKakaoLogin() async {
    try {
      if (await isKakaoTalkInstalled()) {
        return UserApi.instance.loginWithKakaoTalk();
      } else {
        return UserApi.instance.loginWithKakaoAccount();
      }
    } catch (error) {
      print('카카오 로그인 실패 $error');
      return null;
    }
  }

  Future<bool> kakaoLogin(BuildContext context) async {
    // context를 인자로 추가
    OAuthToken? token = await performKakaoLogin();
    if (token != null) {
      print('카카오 로그인 성공');
      await sendToken(token);

      // 여기에 반려동물 정보 확인 로직을 추가
      await checkPetRegistration(context);

      return true;
    }
    return false;
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
    if (storedToken != null) {
      print('저장된 토큰으로 자동 로그인 시도');
      try {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/auth/check');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          print('토큰 검증 성공');
          // 반려동물 정보 확인
          await checkPetRegistration(context);
        } else if (response.statusCode == 403) {
          print('토큰 만료, 새로운 토큰 요청 및 저장 시도');
          // 토큰 만료 시, 새로운 토큰 요청 및 저장 로직 추가
          // await refreshAndStoreToken(context);
        } else {
          print('토큰 검증 실패: ${response.statusCode}');
          print('응답 내용: ${response.body}');
        }
      } catch (error) {
        print('토큰 검증 실패 $error');
      }
    }
  }

  Future<void> checkPetRegistration(BuildContext context) async {
    final storedToken = await _storage.read(key: 'jwt_token');
    if (storedToken != null) {
      try {
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/pet/check');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          if (responseData['success'] == true) {
            print('반려동물 정보가 등록되어 있습니다.');
            Navigator.pushReplacementNamed(context, '/start');
          } else {
            print('반려동물 정보가 등록되어 있지 않습니다.');
            Navigator.pushReplacementNamed(context, '/pet_info_input');
          }
        } else {
          print('반려동물 정보 등록 확인 실패: ${response.statusCode}');
        }
      } catch (error) {
        print('반려동물 정보 등록 확인 실패: $error');
      }
    }
  }
}

class AuthHelper {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> checkKakaoLoginStatus() async {
    final storedToken = await _storage.read(key: 'jwt_token');
    if (storedToken != null) {
      return true;
    } else {
      return false;
    }
  }
}
