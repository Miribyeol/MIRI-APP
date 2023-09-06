import 'package:flutter/material.dart';

class AIOnboardingWidget extends StatelessWidget {
  const AIOnboardingWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    double titleSize = 28;
    double width = 200;
    double height = 200;
    double contentSize = 18;
    double buttonWidth = 20;
    double charTextTop = 60;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonSize = 18;

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
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '별이와 대화하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Image.asset(
                    'assets/icon/star.png',
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    '별이는 상담을 도와주는 AI의 이름으로\n'
                    '별이와의 대화를 통해 고민과 어려움을\n'
                    '해결하는 동반자가 되어 줄 거에요 !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: contentSize,
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
            bottom: charTextTop,
            left: buttonWidth,
            right: buttonWidth,
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
                      250,
                      50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: buttonSize,
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
