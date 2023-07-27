import 'package:flutter/material.dart';
import 'screens/start.dart';
import 'screens/challenge_list.dart';
import 'screens/ai_onboarding.dart';
import 'screens/pet_charnel.dart';
import 'screens/login.dart';
import 'screens/pet_info_input.dart';
import 'screens/story.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Widgets',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: PetInfoInputScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/start': (context) => StartScreen(),
        '/challenge_list': (context) => ChallengeListScreen(),
        '/ai_onboarding': (context) => AIOnboardingScreen(),
        '/pet_charnel': (context) =>
            PetCharnelScreen(), // Modified to 'PetCharnelScreen'
        '/pet_info_input': (context) => PetInfoInputScreen(),
        '/story': (context) => StoryScreen(),
      },
    );
  }
}
