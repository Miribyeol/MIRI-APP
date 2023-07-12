import 'package:flutter/material.dart';

// class StartScreen extends StatefulWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

class ChallengeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("챌린지"),
      ),
      body: Container(
        child: Center(
          child: Text("Challenge List Screen"),
        ),
      ),
    );
  }
}
