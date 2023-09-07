import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miri_app/models/challenge_store.dart';
import 'package:miri_app/screens/challenge_pop_up.dart';
import 'package:miri_app/services/challenge_services.dart';

//챌린지 시작부분
class ChallengPage extends StatelessWidget {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final int day;

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

//챌린지 이미지
  Widget _challengeImage(int day) {
    double width = 500;
    double height = 500;
    assert(day >= 1 && day <= 14, 'Day should be between 1 and 14');

    return Image.asset(
      'assets/image/challenge_day_$day.png',
      width: width,
      height: height,
    );
  }

//챌린지 단계 서버 보내기
  void _completeChallenge(BuildContext context, int day) async {
    int challengeStep = day;

    await sendChallengeStatusToServer(day, challengeStep, storage);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChallengPopUp(day: day);
      },
    );
  }

// 챌린지 화면 UI
  @override
  Widget build(BuildContext context) {
    double contentButtonSize = 35;
    double contentgapHeight = 20;
    double height = 10;
    double width = 10;
    double fontSize = 18;
    double buttonText = 15;
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
                        style: TextStyle(
                            fontSize: contentButtonSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: contentgapHeight,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '오늘 하루는 어떠셨나요?',
                        style: TextStyle(
                            fontSize: fontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _challengeImage(day),
                    ),
                    for (var widget in challengeStart(day))
                      Expanded(flex: 2, child: widget),
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
                  SizedBox(height: height),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // 텍스트를 수직으로 중간에 정렬
                        children: challengeEnd(day).split('\n').map((sentence) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              sentence,
                              style: TextStyle(
                                fontSize: buttonText,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
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
                          child: Text(
                            '목록으로',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: width),
                        ElevatedButton(
                          onPressed: () async {
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
                          child: Text(
                            '완료',
                            style: TextStyle(
                              fontSize: fontSize,
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
