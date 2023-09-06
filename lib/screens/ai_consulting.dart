import 'package:flutter/material.dart';
import '../widgets/ai_consulting_widgets.dart';

class AIConsultingScreen extends StatelessWidget {
  const AIConsultingScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121824),
      body: AIConsultingWidget(),
    );
  }
}
