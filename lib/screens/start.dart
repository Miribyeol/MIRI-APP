import 'package:flutter/material.dart';

// class StartScreen extends StatefulWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/challenge_list');
                },
                child: Text('챌린지'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ai_onboarding');
                },
                child: Text('별이와 대화하기'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pet_charnel');
                },
                child: Text('영원한 발자국'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
