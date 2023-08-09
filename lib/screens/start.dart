import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: const Color(0xFF6B42F8),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/challenge_list');
                    },
                    child: const Text('챌린지'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ai_onboarding');
                    },
                    child: const Text('별이와 대화하기'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pet_charnel');
                    },
                    child: const Text('영원한 발자국'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
