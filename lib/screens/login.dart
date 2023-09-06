import 'package:flutter/material.dart';
import '../services/kakao_login_service.dart';

class LoginScreen extends StatelessWidget {
  final KakaoLoginService kakaoLoginService;

  const LoginScreen({Key? key, required this.kakaoLoginService})
      : super(key: key);

  @override
  Widget build(context) {
    // 자동 로그인 로직 실행
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate relative values based on screen size

    kakaoLoginService.autoLogin(context);
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
              height: screenHeight * 0.8,
              color: const Color(0xFF6B42F8),
            ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/Logo.png',
                  width: screenWidth * 0.8, //300.0 buttonTitleSize*15
                  height: screenWidth * 0.8, //300.0 buttonTitleSize*15
                  color: const Color(0xFF3109AD),
                ),
                SizedBox(height: screenHeight * 0.001),
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
                      final success = await kakaoLoginService
                          .kakaoLogin(context); // context를 전달
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('카카오 로그인에 실패하였습니다.'),
                          ),
                        );
                      }
                    } catch (error) {
                      print("Kakao login error: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('카카오 로그인 중 오류가 발생하였습니다.'),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/image/kakao_login_large_wide.png',
                    width: screenWidth * 0.9, //380
                    height: screenHeight * 0.15, //130
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
