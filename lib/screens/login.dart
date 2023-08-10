import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

//   Future<void> _handleKakaoLogin(BuildContext context) async {
//     final response = await http.post(
//       Uri.parse('https://kauth.kakao.com/oauth/token'),
//       headers: <String, String>{
//         'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
//       },
//       body: <String, String>{
//         'grant_type': 'authorization_code',
//         'client_id': 'YOUR_CLIENT_ID',
//         'redirect_uri': 'YOUR_REDIRECT_URI',
//         'code': 'AUTHORIZATION_CODE',
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final String accessToken = responseData['access_token'];
//       saveAccessToken(accessToken);
//       getProfileInfo(accessToken);
//     }
//   }

//   Future<void> getProfileInfo(String accessToken) async {
//     final response = await http.get(
//       Uri.parse('https://kapi.kakao.com/v2/user/me'),
//       headers: <String, String>{
//         'Authorization': 'Bearer $accessToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> profileData = json.decode(response.body);
//     } else {
//       throw Exception('Failed to fetch profile information.');
//     }
//   }

//   Future<void> saveAccessToken(String accessToken) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('access_token', accessToken);
//   }

//   Future<String?> getAccessToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              color: const Color(0xFF6B42F8),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/Logo.png',
                  width: 300.0,
                  height: 300.0,
                  color: const Color(0xFF3109AD),
                ),
                const SizedBox(height: 20),
                const Text(
                  '미리별로\n\n펫로스 증후군을\n\n극복해보아요 !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pet_info_input');
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
