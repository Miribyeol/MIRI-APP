import 'package:flutter/material.dart';
import 'screens/start.dart';
import 'screens/challenge_list.dart';
import 'screens/ai_onboarding.dart';
import 'screens/pet_charnel.dart';
import 'screens/login.dart';
import 'screens/pet_info_input.dart';
import 'screens/story.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Widgets',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: const PetInfoInputScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/start': (context) => const StartScreen(),
        '/challenge_list': (context) => const ChallengeListScreen(),
        '/ai_onboarding': (context) => const AIOnboardingScreen(),
        '/pet_charnel': (context) =>
            const PetCharnelScreen(), // Modified to 'PetCharnelScreen'
        '/pet_info_input': (context) => const PetInfoInputScreen(),
        '/story': (context) => const StoryScreen(),
      },
    );
  }
}
