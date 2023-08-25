import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // 추가

class MypageScreen extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  const MypageScreen({super.key}); // 추가

  Future<void> _logout(context) async {
    await _storage.delete(key: 'jwt_token'); // jwt_token 토큰값 삭제
    Navigator.pushReplacementNamed(context, '/onboarding'); // 로그인 화면으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B42F8),
        title: const Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold), // 텍스트를 볼드체로 변경
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // 좌우 패딩 추가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mypage_my_info');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2839),
                minimumSize: const Size(double.infinity, 110),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero, // 버튼 내부 패딩 제거
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0), // 왼쪽 패딩 추가
                child: Align(
                  alignment: Alignment.centerLeft, // 텍스트를 왼쪽으로 정렬
                  child: Text(
                    '내 정보 관리',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mypage_pet_info');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2839),
                minimumSize: const Size(double.infinity, 110),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero, // 버튼 내부 패딩 제거
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0), // 왼쪽 패딩 추가
                child: Align(
                  alignment: Alignment.centerLeft, // 텍스트를 왼쪽으로 정렬
                  child: Text(
                    '반려동물 정보 관리',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 430),
            ElevatedButton(
              onPressed: () {
                _logout(context); // 로그아웃 버튼을 눌렀을 때 로그아웃 처리
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3a3b50),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
