import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  double progressValue = 0.1;
  int challengerStep = 0;

  List<String> emotion = [];
  List<Map<String, dynamic>> contentData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://203.250.32.29:3000/main');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(response.body);

          if (jsonResponse['result'].containsKey('challengerStep')) {
            setState(() {
              // Emotion & Content Data
              emotion = (jsonResponse['result']['emotions'] as List)
                  .map((item) => item['emotion'].toString())
                  .toSet()
                  .toList();
              contentData = List<Map<String, dynamic>>.from(
                  jsonResponse['result']['posts']);

              // Day Data
              challengerStep = jsonResponse['result']['challengerStep'] ?? 0;
              print("Updated challengerStep: $challengerStep");
            });
          } else {
            print(
                "The key 'challengerStep' was not found in the jsonResponse.");
          }
        } else {
          print('Failed to fetch data from server: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error fetching data from server: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // int challengerStep = 0;

    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.40),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.41,
          color: const Color(0xff6B42F8),
          child: Stack(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.45,
                color: const Color(0xFF6B42F8),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 55,
                      left: 35,
                      child: Text(
                        '오늘 챌린지\n완료 하셨나요 ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
                      top: 125,
                      left: 30,
                      right: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          DayProgressIndicator(challengerStep: challengerStep),
                          const SizedBox(height: 5),
                          Text(
                            "DAY $challengerStep",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 180,
                      left: 15,
                      child: Text(
                        '  다른 사람들은 어떤 감정을 갖고 있을까요?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 10,
                      left: 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(emotion.length, (index) {
                                if (index < 5) {
                                  return createButton(emotion[index]);
                                }
                                return const SizedBox
                                    .shrink(); // 5개 이후의 아이템은 감춤
                              }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(emotion.length, (index) {
                                if (index >= 5 && index < 10) {
                                  return createButton(emotion[index]);
                                }
                                return const SizedBox
                                    .shrink(); // 10개 이후의 아이템은 감춤
                              }),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 111,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/challenge_list');
                      },
                      //onPressed 실행시 이동이 안되면 이렇게 수정해야함!
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 111,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ai_onboarding');
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 111,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pet_charnel');
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 111,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '   이런 글이\n   당신에게 위로가 될까요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              '더보기',
                              style: TextStyle(
                                color: Color(0xFFBBBBBB),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: contentData.map((item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 111,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2839),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF1F2839),
                                    width: 2.0,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item['content'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Author: ${item['author']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '이 앱을 통해 팻로스 증후군을 극복하시 분의 소중한 경험을 공유해 주세요.\n여러분의 소중한 이야기는 다른 사용자들에게 희망과 위로를 전달하고,\n함께 힘을 나눌 수 있는 소중한 자산이 될 것입니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff7d8086),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            const mailtoLink = 'mailto:hnvvely@gmail.com';
                            if (await canLaunch(mailtoLink)) {
                              await launch(mailtoLink);
                            } else {
                              throw 'Could not launch $mailtoLink';
                            }
                          },
                          child: const Text(
                            'hnvvely@gmail.com',
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(String label) {
    double paddingFactor = 1.0; // Adjust the factor as needed
    double minWidth = 130.0; // Minimum width for the button
    double paddingHorizontal = label.length * paddingFactor;

    double width = minWidth + paddingHorizontal;
    double height = 40.0; // You can adjust the height as needed

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3D4353), // 배경색
        borderRadius: BorderRadius.circular(8.0), // 버튼 모서리 둥글게
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // 그림자의 색상
            spreadRadius: 0,
            blurRadius: 5, // 그림자의 블러량
            offset: const Offset(0, 5), // 그림자의 위치
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Text(
            '# $label',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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

//day표시바
class DayProgressIndicator extends StatelessWidget {
  final int challengerStep;

  const DayProgressIndicator({super.key, this.challengerStep = 0});

  @override
  Widget build(BuildContext context) {
    double value = challengerStep / 14.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        height: 15,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xFF492E9D),
          ),
        ),
      ),
    );
  }
}
