import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLoginService {
  Future<void> sendToken(token) async {
    try {
      print('사용자 토큰 요청 성공'
          '\n토큰: $token');
      var tokenManager = DefaultTokenManager();
      tokenManager.setToken(token);

      var url = Uri.parse('http://192.168.200.192:3000/auth/login');
      var body = jsonEncode(token);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
      print('response: $response');
    } catch (error) {
      print('사용자 토큰 요청 실패 $error');
    }
  }

  Future kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        sendToken(token);
        return true;
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          sendToken(token);
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        sendToken(token);
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  Future<void> kakaoLogout() async {
    try {
      await UserApi.instance.logout();
      print('Logged out from Kakao');
    } catch (error) {
      print('Logout error: $error');
    }
  }
}
