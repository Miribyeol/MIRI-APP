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

  List<String> emotion = [];
  List<Map<String, dynamic>> contentData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://203.250.32.29:3000/main');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken', // Include the token
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(response.body);
          setState(() {
            emotion = (jsonResponse['result']['emotions'] as List)
                .map((item) => item['emotion'].toString())
                .toSet() // Convert to set to remove duplicates
                .toList(); // Convert back to list

            contentData = List<Map<String, dynamic>>.from(
                jsonResponse['result']['posts']);
          });
        } else {
          print('Failed to fetch pet info: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error fetching pet info: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Replace this variable with the actual progress value (0 to 1) of ChallengPage 1~14단계
    double progressValue = 0.1;

    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.39),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.39,
          color: const Color(0xff6B42F8),
          child: Stack(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.45,
                color: const Color(0xFF6B42F8),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 45,
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
                      top: 10,
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
                          SizedBox(
                            height: 15,
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.white,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF492E9D),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "DAY 1",
                            style: TextStyle(
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
                      top: 210,
                      right: 10,
                      left: 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10, // 버튼 사이의 간격 조절
                              runSpacing: 10, // 줄 간의 간격 조절
                              alignment: WrapAlignment.start,
                              children: emotion.map((emotion) {
                                return createButton(emotion,
                                    width: 120, height: 40);
                              }).toList(),
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
                        Navigator.pushNamed(context, '/challenge_list');
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
                      return Column(
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
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['content'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Author: ${item['author']}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Adjust spacing here
                        ],
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

  Widget createButton(String label, {double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5.0), // 간격을 주기 위한 마진
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
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
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
