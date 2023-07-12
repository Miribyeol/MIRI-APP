import 'package:flutter/material.dart';

// class StartScreen extends StatefulWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

class AIOnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("별이와 대화하기"),
      ),
      body: Container(
        child: Center(
          child: Text("AI Onboarding Screen"),
        ),
      ),
    );
  }
}