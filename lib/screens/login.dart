import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              color: const Color(0xFF6B42F8),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.2, // Adjust this value as needed to center the text.
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/Logo.png', // Add the image 'star.png' to your assets folder
                  width: 300.0,
                  height: 300.0,
                  color: const Color(0xFF3109AD),
                ), // Adding the logo image
                const SizedBox(height: 20), // Adding some spacing
                const Text(
                  '미리별로\n\n펫로스 증후군을\n\n극복해보아요 !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
