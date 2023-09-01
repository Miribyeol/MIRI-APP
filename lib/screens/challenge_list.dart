import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miri_app/screens/challenge.dart';

class ChallengeListScreen extends StatefulWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  const ChallengeListScreen({super.key});

  @override
  ChallengeListScreenState createState() => ChallengeListScreenState();
}

class ChallengeListScreenState extends State<ChallengeListScreen> {
  List<bool> daysCompleted = List.filled(14, false);
  List<int> challengeStep = [];

  @override
  void initState() {
    super.initState();
    loadChallengeStatusFromServer();
    //loadDays();
  }

  Future<void> loadChallengeStatusFromServer() async {
    try {
      final storedToken = await widget._storage.read(key: 'jwt_token');
      if (storedToken != null) {
        final url = Uri.parse('http://203.250.32.29:3000/main');

        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
        );
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          // challengerStep 값을 가져옵니다.
          int stepValue = data['result']['challengerStep'];

          // 가져온 challengerStep 값을 로그로 출력합니다.
          print('challengeStep from server: $stepValue');

          // stepValue를 원하는 방식으로 사용합니다. 예를 들어, List를 생성하려면:
          setState(() {
            challengeStep = List.generate(stepValue, (index) => index + 1);
          });
        } else {
          print(
              'Server returned an error: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (e) {
      print('Error getting challenge status: $e');
    }
  }

  //챌린지 리스트 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121824),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(left: 16.0),
            color: Color(0xFF121824),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '챌린지',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '14일동안 미션을 수행해보아요',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          backgroundColor: Color(0xFF121824),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...List.generate(14, (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 111,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff121824), // Shadow color
                            blurRadius: 5.0, // Amount of blur
                            offset: Offset(0, 4), // Offset of the shadow
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (challengeStep.contains(index + 1)) {
                            // 버튼이 회색일 경우 (챌린지 완료한 경우)
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("이미 완료한 챌린지 입니다"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("확인"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else if (index + 1 >
                              (challengeStep.isNotEmpty
                                  ? challengeStep.last + 1
                                  : 1)) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("알림"),
                                  content: Text("이전 챌린지를 완료하지 않았습니다"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("확인"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChallengPage(day: index + 1),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              // 챌린지를 완료한 경우 회색
                              challengeStep.contains(index + 1)
                                  ? Color(0xff1F2839)
                                  // 이전 챌린지를 완료하지 않은 경우 빨간색
                                  : (index + 1 >
                                          (challengeStep.isNotEmpty
                                              ? challengeStep.last + 1
                                              : 1))
                                      ? Color(0xff1F2839)
                                      // 그 외의 경우 기본 색상
                                      : const Color(0xff6B42F8)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Day ${index + 1}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
