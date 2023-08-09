import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'challenge_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoarding(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this variable with the actual progress value (0 to 1) of ChallengPage 1~14단계
    double progressValue = 0.1;

    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.41,
              color: const Color(0xFF6B42F8),
              child: Stack(
                children: [
                  const Positioned(
                    top: 85,
                    left: 35,
                    child: Text(
                      '오늘 챌린지\n완료 하셨나요 ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mypage');
                      },
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 165,
                    left: 30,
                    right: 30,
                    child: SizedBox(
                      height: 15,
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF492E9D),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 230,
                    left: 15,
                    child: Text(
                      '다른 사람들은 어떤 감정을 갖고 있을까요?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 15,
                    right: 0,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildEmotionTextBox('#기분전환'),
                        buildEmotionTextBox('#희망찬'),
                        buildEmotionTextBox('#보람찬'),
                        buildEmotionTextBox('#우울한'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 320,
                    left: 10,
                    right: 0,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildEmotionTextBox('#떠나고 싶은'),
                        buildEmotionTextBox('#후회스러운'),
                        buildEmotionTextBox('#두려운'),
                        buildEmotionTextBox('#불면증'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 111,
                    child: ElevatedButton(
                      //onPressed 실행시 이동이 안되면 이렇게 수정해야함!
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChallengeListScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F2839),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\n 챌린지',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              ' 14일동안 미션을 수행해보아요',
                              style: TextStyle(
                                color: Color(0xFFBBBBBB),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 111,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ai_onboarding');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF1F2839),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\n 별이와 대화하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              ' 미리별 만의 AI 친구 별이에게 고민을 말해보세요 !',
                              style: TextStyle(
                                color: Color(0xFFBBBBBB),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 111,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pet_charnel');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF1F2839),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\n 영원한 발자국',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              ' 애완동물과 함께한 순간들을 기억하는 공간',
                              style: TextStyle(
                                color: Color(0xFFBBBBBB),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  // Add your action for the "더보기" button here
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a textbox for each emotion
  Widget buildEmotionTextBox(String emotionText) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFF3D4353),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        emotionText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
