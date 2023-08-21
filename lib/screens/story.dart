import 'package:flutter/material.dart';
import 'package:miri_app/screens/start.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          const Positioned(
            top: 380.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '펫로스 증후군 극복을 위해 미리별이 함께합니다.\n\n\n'
                '당신의 소중한 반려동물을 기억하며,\n치유와 위로를 전해드립니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8),
                minimumSize: const Size(double.infinity,
                    50), // Set the width and height of the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius here
                ),
              ),
              child: const Text(
                '시작하기',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
