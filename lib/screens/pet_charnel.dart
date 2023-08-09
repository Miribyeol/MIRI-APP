import 'package:flutter/material.dart';

// class StartScreen extends StatefulWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

class PetCharnelScreen extends StatelessWidget {
  const PetCharnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("영원한 발자국"),
      ),
      body: Container(
        child: const Center(
          child: Text("Pet Charnel Screen"),
        ),
      ),
    );
  }
}
