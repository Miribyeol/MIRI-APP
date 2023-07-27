import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121824),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              color: Color(0xFF6B42F8),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.5, // Adjust this value as needed to center the text.
            left: 0,
            right: 0,
            child: Center(
              child: Text('미리별로\n\n펫로스 증후군을\n\n극복해보아요 !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
