import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var children2 = [
      Positioned(
        top: screenHeight * 0.18,
        left: screenWidth * 0.03,
        child: _buildCircle(147, const Color(0xFFFFA0A0)),
      ),
      Positioned(
        top: screenHeight * 0.18,
        left: screenWidth * 0.43,
        child: _buildCircleWithText(110, const Color(0xFF4F4867), "우울감", 20),
      ),
      Positioned(
        top: screenHeight * 0.26,
        left: screenWidth * 0.7,
        child: _buildCircleWithImage(138, 'assets/image/onboarding_m_cat.jpeg'),
      ),
      Positioned(
        top: screenHeight * 0.36,
        left: screenWidth * -0.14,
        child: _buildCircleWithText(137, const Color(0xFF9F8DDC), "외로움", 24),
      ),
      Positioned(
        top: screenHeight * 0.33,
        left: screenWidth * 0.22,
        child: _buildCircleWithImage(213, 'assets/image/onboarding_dog.jpeg'),
      ),
      Positioned(
        top: screenHeight * 0.43,
        left: screenWidth * 0.73,
        child:
            _buildCircleWithText(156, const Color(0xFF6B42F8), "펫로스 증후군", 23),
      ),
      Positioned(
        top: screenHeight * 0.53,
        left: screenWidth * 0.06,
        child: _buildCircleWithText(116, const Color(0xFFB36EBE), "반려동물", 20),
      ),
      Positioned(
        top: screenHeight * 0.58,
        left: screenWidth * 0.40,
        child: _buildCircleWithImage(143, 'assets/image/onboarding_cat.jpeg'),
      ),
      Positioned(
        top: screenHeight * 0.66,
        left: screenWidth * -0.12,
        child: _buildCircle(100, const Color(0xFF646A6B)),
      ),
      Positioned(
        top: screenHeight * 0.69,
        left: screenWidth * 0.12,
        child: _buildCircle(141, const Color(0xFF8FC2DD)),
      ),
      Positioned(
        top: screenHeight * 0.75,
        left: screenWidth * 0.48,
        child: _buildArrowCircle(118, const Color(0xFF0A85A1), context),
      ),
      Positioned(
        top: screenHeight * 0.65,
        left: screenWidth * 0.77,
        child: _buildCircle(115, const Color(0xFFE4E3E3)),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Center(
        child: Stack(
          children: children2,
        ),
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
