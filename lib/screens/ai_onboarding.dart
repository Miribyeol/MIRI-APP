import 'package:flutter/material.dart';

class AIOnboardingScreen extends StatelessWidget {
  const AIOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // '<' 아이콘 클릭 시 이전 화면으로 돌아가도록 수정
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 90.0),
                  const Text(
                    '별이와 대화하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80.0),
                  Image.asset(
                    'assets/icon/star.png', // Add the image 'star.png' to your assets folder
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 70.0),
                  const Text(
                    '별이는 상담을 도와주는 AI의 이름으로\n'
                    '별이와의 대화를 통해 고민과 어려움을\n'
                    '해결하는 동반자가 되어 줄 거에요 !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle the button press to proceed
                    // Replace `NextScreenPage` with the page you want to navigate to
                    // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreenPage()),);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42F8),
                    minimumSize:
                        const Size(250, 50), // Set the width and height of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25.0), // Set the border radius here
                    ),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
