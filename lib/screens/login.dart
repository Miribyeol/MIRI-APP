import 'package:flutter/material.dart';
import '../services/kakao_login.dart';

class LoginScreen extends StatelessWidget {
  final KakaoLoginService kakaoLoginService;

  const LoginScreen({Key? key, required this.kakaoLoginService})
      : super(key: key);

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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    try {
                      final success = await kakaoLoginService.kakaoLogin();
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/story');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('카카오 로그인에 실패하였습니다.'),
                          ),
                        );
                      }
                    } catch (error) {
                      print("Kakao login error: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('카카오 로그인 중 오류가 발생하였습니다.'),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/image/kakao_login_large_wide.png',
                    width: 380,
                    height: 130,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
