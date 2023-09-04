import 'package:flutter/material.dart';
import '../widgets/onboarding_widgets.dart'; // Import the widget file

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121824),
      body: OnboardingContent(), // Use the OnboardingContent widget
    );
  }
}
