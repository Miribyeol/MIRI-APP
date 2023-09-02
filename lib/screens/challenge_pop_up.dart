import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:miri_app/models/challenge_store.dart';

//팝업창
class ChallengPopUp extends StatefulWidget {
  final int day;

  const ChallengPopUp({super.key, required this.day});

  @override
  ChallengPopUpState createState() => ChallengPopUpState();
}

class ChallengPopUpState extends State<ChallengPopUp> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  int selectedDay = 1;
  Set<int> selectedButtons = {};

//감정 선택후 전송기능
  Future<void> sendChallengeFeedbackToServer(List<String> emotions) async {
    try {
      if (emotions.isEmpty || emotions.length > 3) {
        print('최대 3개까지 선택하세요');
        return;
      }

      final storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var apiUrl = dotenv.env['API_URL'];
        final url = Uri.parse('$apiUrl/emotion');

        final response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'emotions': emotions, // Only the list of emotions is sent
          }),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 201) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('완료되었습니다'),
              content: const Text('챌린지가 성공적으로 완료되었습니다!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 성공 대화 상자 닫기
                    Navigator.of(context).pop(); // 도전 팝업 닫기
                    Navigator.of(context).pushReplacementNamed('/start');
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print('Error sending challenge feedback: $e');
    }
  }

//팝업창에서 최대 3개의 버튼을 선택하게하기
  Widget createButton(int index, {double width = 100.0, double height = 30.0}) {
    bool isSelected = selectedButtons.contains(index);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () {
            if (isSelected) {
              setState(() {
                selectedButtons.remove(index);
              });
            } else if (selectedButtons.length < 3) {
              setState(() {
                selectedButtons.add(index);
              });
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('수고하셨습니다.'),
                  content: const Text('최대 3개까지만 선택해 주세요.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('ok'),
                    ),
                  ],
                ),
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              isSelected ? const Color(0xff6b42f8) : const Color(0xff3D4353),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            elevation: MaterialStateProperty.all(5.0),
          ),
          child: Text(
            '# ${buttonTexts[index]}',
            style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

// 완료시 팝업창 UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5.0,
      title: Text(
        '${widget.day}일차 수고했어요!',
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '방금 챌린지를 마친 기분이 어떤지 알려줄래요?',
            style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: 383,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createButton(0, width: 100, height: 34),
                      createButton(1, width: 85, height: 34),
                      createButton(2, width: 85, height: 34),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createButton(3, width: 85, height: 34),
                      createButton(4, width: 160, height: 34),
                      createButton(5, width: 70, height: 34),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createButton(6, width: 160, height: 34),
                      createButton(7, width: 100, height: 34),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createButton(8, width: 130, height: 34),
                      createButton(9, width: 85, height: 34),
                      createButton(10, width: 120, height: 34),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createButton(11, width: 120, height: 34),
                      createButton(12, width: 85, height: 34),
                      createButton(13, width: 85, height: 34),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              List<String> selectedEmotions = selectedButtons.map((int index) {
                return buttonTexts[index];
              }).toList();
              sendChallengeFeedbackToServer(selectedEmotions);
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(308, 35)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF6B42F8)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              elevation: MaterialStateProperty.all(5.0),
            ),
            child: const Text(
              '완료',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          // const SizedBox(height: 10),
          TextButton(
            child: const Text(
              '안할래요',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/start');
            },
          ),
        ],
      ),
    );
  }
}
