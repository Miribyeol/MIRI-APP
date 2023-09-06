import 'package:flutter/material.dart';

class MiriStationScreen extends StatelessWidget {
  const MiriStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double contentSize = 18;
    double width = 200;
    double height = 200;
    double titleTextSize = 28;
    double iconSize = 40;
    double buttonTextTop = 60;
    double buttonContentSize = 20;
    double screenHeight = MediaQuery.of(context).size.height;
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
                  SizedBox(height: screenHeight * 0.1), //50.0
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // '<' 아이콘 클릭 시 이전 화면으로 돌아가도록 수정
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 90.0),
                  Text(
                    '미리별 정거장',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.1), //80.0
                  Image.asset(
                    'assets/icon/star.png', // Add the image 'star.png' to your assets folder
                    width: width,
                    height: height,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: buttonTextTop,
            left: buttonContentSize,
            right: buttonContentSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ai_consulting');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42F8),
                    minimumSize: const Size(
                        250, 50), // Set the width and height of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25.0), // Set the border radius here
                    ),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: contentSize,
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
