import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();

    // 3초 동안 대기 후 start.dart 화면으로 이동
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/start');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/Logo.png', // 이미지 파일의 경로
              width: 244, // 이미지 너비 조정
              height: 271, // 이미지 높이 조정
            ),
            /*
            SizedBox(height: 20),
            Text(
              '로고 화면',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              
            ),*/
          ],
        ),
      ),
    );
  }
}
