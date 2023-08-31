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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var children2 = [
      Positioned(
        top: screenHeight * 0.10,
        left: screenWidth * 0.07,
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
        top: screenHeight * 0.06,
        right: screenWidth * 0.05,
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/mypage');
          },
          icon: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      Positioned(
        top: screenHeight * 0.17,
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.01),
            DayProgressIndicator(challengerStep: challengerStep),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "DAY $challengerStep",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: screenHeight * 0.29,
        left: screenWidth * 0.03,
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
        top: screenHeight * 0.32,
        right: screenWidth * 0.01,
        left: screenWidth * 0.01,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 10.0,
            children: List.generate(emotion.length, (index) {
              if (index < 5) {
                return createButton(emotion[index]);
              }
              return SizedBox.shrink();
            }),
          ),
        ),
      ),
      Positioned(
        top: screenHeight * 0.32 +
            50.0, // Adjust the top value for the second row
        right: screenWidth * 0.01,
        left: screenWidth * 0.01,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 10.0,
            children: List.generate(emotion.length, (index) {
              if (index >= 5 && index < 10) {
                return createButton(emotion[index]);
              }
              return SizedBox.shrink();
            }),
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.40),
        child: Container(
          height: screenHeight * 0.44,
          color: const Color(0xff6B42F8),
          child: Stack(
            children: [
              Container(
                color: const Color(0xFF6B42F8),
                child: Stack(
                  children: children2,
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: screenHeight * 0.12,
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
                      child: Align(
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
                            SizedBox(height: screenHeight * 0.012),
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
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.12,
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
                            SizedBox(height: screenHeight * 0.012),
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
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.12,
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
                            SizedBox(height: screenHeight * 0.012),
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
                  SizedBox(height: screenHeight * 0.015),
                  SizedBox(
                    height: screenHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '   이런 글이\n   당신에게 위로가 될까요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: screenHeight * 0.025),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
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
                              height: screenHeight * 0.12,
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
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.012),
                                      Text(
                                        item['content'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.012),
                                      Text(
                                        'Author: ${item['author']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    height: screenHeight * 0.145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
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
                          child: Text(
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

  double calculateTotalWidth(List<String> emotions) {
    double totalWidth = 0.0;
    for (var emotion in emotions) {
      double buttonWidth = 100.0 + (emotion.length + 10) * 1.0;
      totalWidth += buttonWidth;
    }
    return totalWidth;
  }

  Widget createButton(String label) {
    double fontSize = 15.0;
    double widthPerChar = fontSize;

    double width = (label.length * widthPerChar) + 30.0;
    double height = 40.0;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3D4353),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '# $label',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DayProgressIndicator extends StatelessWidget {
  final int challengerStep;

  const DayProgressIndicator({this.challengerStep = 0});

  @override
  Widget build(BuildContext context) {
    double value = challengerStep / 14.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        height: 15,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFF492E9D),
          ),
        ),
      ),
    );
  }
}
