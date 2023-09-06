import 'package:flutter/material.dart';
import '../widgets/ai_onboarding_widgets.dart';

class AIOnboardingScreen extends StatelessWidget {
  const AIOnboardingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121824),
      body: AIOnboardingWidget(),
    );
  }
}
