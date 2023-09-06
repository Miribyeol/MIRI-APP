import 'package:flutter/material.dart';

class MypageWidget extends StatelessWidget {
  final Future<void> Function(BuildContext) logoutFunction; // 타입 변경

  const MypageWidget({Key? key, required this.logoutFunction});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonHeight = screenHeight * 0.13;
    double buttonTitleSize = 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B42F8),
        title: const Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF121824),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mypage_my_info');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2839),
                minimumSize: Size(double.infinity, buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '내 정보 관리',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonTitleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mypage_pet_info');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2839),
                minimumSize: Size(double.infinity, buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '반려동물 정보 관리',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: buttonTitleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.43),
            ElevatedButton(
              onPressed: () {
                logoutFunction(context); // 수정된 호출 방식
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3a3b50),
                minimumSize: Size(double.infinity, buttonHeight * 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
