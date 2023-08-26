import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miri_app/models/challenge_store.dart';
import 'package:miri_app/screens/challenge_pop_up.dart';

//챌린지 시작부분
class ChallengPage extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final int day;

  Future<void> sendChallengeStatusToServer(int day, int challengeStep) async {
    try {
      final storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        final url = Uri.parse('http://203.250.32.29:3000/challenge/status');

        final response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'day': day.toString(),
            'challengeStep': challengeStep.toString(),
          }),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending challenge status: $e');
    }
  }

  const ChallengPage({Key? key, required this.day}) : super(key: key);

//챌린지 윗부분
  List<Widget> challengeWidgets(int day) {
    return challengeStart(day);
  }

//챌린지 아랫부분
  void someFunction() {
    String todayChallenge = challengeEnd(1);
    print(todayChallenge);
  }

// //DAY완료 여부 서버에 전달
//   Future<void> sendChallengeStatusToServer(int day, int challengeStep) async {
//     try {
//       final storedToken = await _storage.read(key: 'jwt_token');
//       if (storedToken != null) {
//         final url = Uri.parse('http://203.250.32.29:3000/challenge/status');

//         final response = await http.patch(
//           url,
//           headers: {
//             'Authorization': 'Bearer $storedToken',
//             'Content-Type': 'application/json',
//           },
//           body: jsonEncode({
//             'day': day.toString(),
//             'challengeStep': challengeStep.toString(),
//           }),
//         );

//         print('Response status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending challenge status: $e');
//     }
//   }

//챌린지 이미지관련
  Widget _challengeImage(int day) {
    assert(day >= 1 && day <= 14, 'Day should be between 1 and 14');

    return Image.asset(
      'assets/image/challenge_day_$day.png',
      width: 500,
      height: 500,
    );
  }

  // void _completeChallenge(BuildContext context, int day) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ChallengPopUp(day: day, challengeStep: day);
  //     },
  //   );
  // }

// 챌린지 화면 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff6b42f8),
          elevation: 0,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              color: const Color(0xff6b42f8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Day $day',
                        style: const TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        '오늘 하루는 어떠셨나요?',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _challengeImage(day),
                    ),
                    for (var widget in challengeWidgets(day))
                      Expanded(flex: 1, child: widget),
                    // ..._challengeStory(day),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xff121824),
              child: Center(
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        challengeEnd(day),
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff3A3B50)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(163, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(5.0),
                          ),
                          child: const Text(
                            '목록으로',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _completeChallenge(context, day);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF6B42F8)),
                            fixedSize:
                                MaterialStateProperty.all(const Size(163, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(5.0),
                          ),
                          child: const Text(
                            '완료',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
