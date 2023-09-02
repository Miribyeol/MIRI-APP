import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          var children2 = [
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.03,
              child: _buildCircle(screenWidth * 0.35, const Color(0xFFFFA0A0)),
            ),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.43,
              child: _buildCircleWithText(
                  screenWidth * 0.30, const Color(0xFF4F4867), "우울감", 20),
            ),
            Positioned(
              top: screenHeight * 0.22,
              left: screenWidth * 0.7,
              child: _buildCircleWithImage(
                  screenWidth * 0.35, 'assets/image/onboarding_m_cat.jpeg'),
            ),
            Positioned(
              top: screenHeight * 0.32,
              left: screenWidth * -0.2,
              child: _buildCircleWithText(
                  screenWidth * 0.35, const Color(0xFF9F8DDC), "외로움", 24),
            ),
            Positioned(
              top: screenHeight * 0.29,
              left: screenWidth * 0.17,
              child: _buildCircleWithImage(
                  screenWidth * 0.58, 'assets/image/onboarding_dog.jpeg'),
            ),
            Positioned(
              top: screenHeight * 0.44,
              left: screenWidth * 0.75,
              child: _buildCircleWithText(
                  screenWidth * 0.40, const Color(0xFF6B42F8), "펫로스 증후군", 23),
            ),
            Positioned(
              top: screenHeight * 0.53,
              left: screenWidth * 0.02,
              child: _buildCircleWithText(
                  screenWidth * 0.30, const Color(0xFFB36EBE), "반려동물", 20),
            ),
            Positioned(
              top: screenHeight * 0.57,
              left: screenWidth * 0.40,
              child: _buildCircleWithImage(
                  screenWidth * 0.35, 'assets/image/onboarding_cat.jpeg'),
            ),
            Positioned(
              top: screenHeight * 0.68,
              left: screenWidth * -0.15,
              child: _buildCircle(screenWidth * 0.24, const Color(0xFF646A6B)),
            ),
            Positioned(
              top: screenHeight * 0.70,
              left: screenWidth * 0.11,
              child: _buildCircle(screenWidth * 0.35, const Color(0xFF8FC2DD)),
            ),
            Positioned(
              top: screenHeight * 0.76,
              left: screenWidth * 0.50,
              child: _buildArrowCircle(
                  screenWidth * 0.30, const Color(0xFF0A85A1), context),
            ),
            Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.77,
              child: _buildCircle(screenWidth * 0.30, const Color(0xFFE4E3E3)),
            ),
          ];

          return Center(
            child: Stack(
              children: children2,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildCircleWithImage(double size, String imagePath) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildArrowCircle(double size, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to login screen
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: size * 0.6,
        ),
      ),
    );
  }

  Widget _buildCircleWithText(
      double size, Color color, String text, double fontSize) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();

    // 3초 동안 대기 후 start.dart 화면으로 이동
    Future.delayed(Duration(seconds: 1), () {
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
