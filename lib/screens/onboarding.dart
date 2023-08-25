import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Center(
        child: Stack(
          children: [
            //positioned-> top에 100px씩 감소
            Positioned(
              top: 50,
              left: 20,
              child: _buildCircle(143, const Color(0xFFFFA0A0)),
            ),
            Positioned(
              top: 70,
              left: 190,
              child: _buildCircleWithText(
                  106.62, const Color(0xFF4F4867), "우울감", 20),
            ),
            Positioned(
              top: 140,
              left: 300,
              child: _buildCircleWithImage(
                  134, 'assets/image/onboarding_m_cat.jpeg'),
            ),
            Positioned(
              top: 215,
              left: -40,
              child:
                  _buildCircleWithText(133, const Color(0xFF9F8DDC), "외로움", 24),
            ),
            Positioned(
              top: 200,
              left: 107,
              child: _buildCircleWithImage(
                  209, 'assets/image/onboarding_dog.jpeg'),
            ),
            Positioned(
              top: 320,
              left: 310,
              child: _buildCircleWithText(
                  152, const Color(0xFF6B42F8), "펫로스 증후군", 23),
            ),
            Positioned(
              top: 380,
              left: 20,
              child: _buildCircleWithText(
                  112, const Color(0xFFB36EBE), "반려동물", 20),
            ),
            Positioned(
              top: 430,
              left: 160,
              child: _buildCircleWithImage(
                  139, 'assets/image/onboarding_cat.jpeg'),
            ),
            Positioned(
              top: 500,
              left: -50,
              child: _buildCircle(95, const Color(0xFF646A6B)),
            ),
            Positioned(
              top: 550,
              left: 50,
              child: _buildCircle(137, const Color(0xFF8FC2DD)),
            ),
            Positioned(
              top: 590,
              left: 210,
              child: _buildArrowCircle(114, const Color(0xFF0A85A1), context),
            ),
            Positioned(
              top: 500,
              left: 320,
              child: _buildCircle(111, const Color(0xFFE4E3E3)),
            ),
          ],
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
