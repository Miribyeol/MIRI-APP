import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

//챌린지 윗부분 내용
  List<Widget> _challengeStory(int day) {
    const TextStyle customStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    switch (day) {
      case 1:
        return [
          const Text('친구나 가족과의 만남', style: customStyle),
        ];
      case 2:
        return [
          const Text('물 마시기', style: customStyle),
        ];
      case 3:
        return [
          const Text('명상 및 호흡 운동', style: customStyle),
        ];
      case 4:
        return [
          const Text('음악 감상', style: customStyle),
        ];
      case 5:
        return [
          const Text('자기 사랑 연습', style: customStyle),
        ];
      case 6:
        return [
          const Text('긍정적인 인용구 모으기', style: customStyle),
        ];
      case 7:
        return [
          const Text('자기 선물', style: customStyle),
        ];
      case 8:
        return [
          const Text('봉사 활동', style: customStyle),
        ];
      case 9:
        return [
          const Text('웃음 요법', style: customStyle),
        ];
      case 10:
        return [
          const Text('사진 도전', style: customStyle),
        ];
      case 11:
        return [
          const Text('자연 치유', style: customStyle),
        ];
      case 12:
        return [
          const Text('일기 쓰기', style: customStyle),
        ];
      case 13:
        return [
          const Text('책 읽기', style: customStyle),
        ];
      case 14:
        return [
          const Text('새로운 취미 시작', style: customStyle),
        ];
      default:
        return [
          const Text('그 외 내용'),
        ];
    }
  }

//챌린지 아랫부분 내용
  String _challengeEnd(int day) {
    switch (day) {
      case 1:
        return '사랑하는 사람들과 함께 시간을 보내면\n 우울감을 완화시킬 수 있습니다.\n 커피를 마시거나 산책을 함께 하며\n 대화하는 것도 좋은 방법입니다.';
      case 2:
        return '시원한 물을 마시면 우울감을\n 완화시키고 긴장을 풀 수 있습니다.';
      case 3:
        return '명상이나 깊은 호흡 운동은 스트레스를 해소하고\n 정신을 집중시키는 데 도움을 줄 수 있습니다.\n 조용한 장소에서 몇 분 동안 집중하여\n 명상을 실천해보세요.';
      case 4:
        return '좋아하는 음악을 듣고 감상해보세요.\n 음악은 감정을 표현하고 치유하는 데\n 큰 도움이 될 수 있습니다.';
      case 5:
        return '거울을 보면서 자신에게"나를 사랑합니다."하고 말해보세요.\n 자기 자신을 받아들이고 사랑하는 것은\n 펫로스 증후군 극복에 중요한 부분입니다.';
      case 6:
        return '긍정적인 인용구를 찾아 모아보세요.\n 이를 읽으면서 긍정적인 생각과 에너지를 얻을 수 있습니다.';
      case 7:
        return '자신을 위한 작은 선물을 준비하세요.\n 좋아하는 디저트, 영화 감상, 스파 트리트먼트 등을\n 선택할 수 있습니다.\n 자기 자신에 대한 관심과 사랑을 나타내는 작은 행위입니다.';
      case 8:
        return '다른 사람들을 도우며 자신의 기분을 개선하세요.\n 자원봉사 활동이나 가까운 이웃을 돕는 일 등의 방법을\n 고려해보세요.';
      case 9:
        return '웃음 요법을 실천해보세요.\n 코미디 영화나 유머 쇼를 시청하거나 웃긴 이야기를 읽어보세요.\n 웃음은 스트레스를 완화하고\n 긍정적인 기분을 불러일으킬 수 있습니다.';
      case 10:
        return '주제를 정하고 그에 맞는 사진을 찍어보세요.\n 사진은 순간을 기록하고 창의성을 자극하는데 도움이 됩니다.';
      case 11:
        return '자연 속에서 힐링을 경험해보세요.\n 숲 산책, 해변산책, 정원 가꾸기 등 자연에서 접근하면서\n 치유와 평온을 찾아보세요.';
      case 12:
        return '일기를 쓰면서 감정을 표현하고 내면의 갈등을 기록해보세요.\n 일기 쓰기는 정신적인 부담을 줄이고,\n 자신을 이해하는 데 도움을 줄 수 있습니다.';
      case 13:
        return '자기계발서나 긍정적인 영향을 주는 소설을 읽어보세요.\n 독서는 마음을 안정시키고\n 새로운 아이디어를 제공할 수 있습니다.';
      case 14:
        return '새로운 취미를 찾아보고 도전해보세요.\n 그림그리기, 음악 연주, 요리, 정원 가꾸기 등\n 다양한 옵션이 있을 수 있습니다.\n 자기계발을 위해 도전해보는 것도 좋습니다.';
      default:
        return '오늘의 명언';
    }
  }

  Widget _challengeImage(int day) {
    assert(day >= 1 && day <= 14, 'Day should be between 1 and 14');

    return Image.asset(
      'assets/image/challenge_day_$day.png',
      width: 500,
      height: 500,
    );
  }

  void _completeChallenge(BuildContext context, int day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChallengPopUp(day: day, challengeStep: day);
      },
    );
  }

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
                    for (var widget in _challengeStory(day))
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
                        _challengeEnd(day),
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

//팝업창 시작 부분
class ChallengPopUp extends StatefulWidget {
  final int day;
  final int challengeStep; // Add this line

  const ChallengPopUp(
      {Key? key, required this.day, required this.challengeStep})
      : super(key: key);

  @override
  ChallengPopUpState createState() => ChallengPopUpState();
}

class ChallengPopUpState extends State<ChallengPopUp> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  int selectedDay = 1;
  Set<int> selectedButtons = {};
  List<String> buttonTexts = [
    '기분전환',
    '희망찬',
    '보람찬',
    '우울한',
    '드라이브 가고 싶은',
    '미련',
    '아직 잘 모르겠어요',
    '울고 싶은',
    '어제보다 나은',
    '무력한',
    '떠나고 싶은',
    '후회스러운',
    '두려운',
    '불면증',
  ];

  Future<void> sendChallengeFeedbackToServer(
      int day, int challengeStep, List<String> emotions) async {
    try {
      print(day);
      final storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        final url = Uri.parse('http://203.250.32.29:3000/emotion');
        final url2 = Uri.parse('http://203.250.32.29:3000/challenge/status');

        final response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            //'day': day.toString(),
            // 'challengeStep': challengeStep.toString(), // Add this line
            'emotions': emotions,
          }),
        );

        final response2 = await http.patch(
          url2,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            // 'day': day.toString(),
            'challengeStep': day.toString(), // Add this line
            // 'emotions': emotions,
          }),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        print('Response2 status code: ${response2.statusCode}');
        print('Response2 body: ${response2.body}');

        if (response.statusCode == 201 && response2.statusCode == 201) {
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
                    Navigator.of(context)
                        .pushReplacementNamed('/start'); // StartScreen으로 이동
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
                  title: const Text('error'),
                  content: const Text('max 3'),
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
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '방금 챌린지를 마친 기분이 어떤지 알려줄래요?',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              List<String> selectedEmotions = selectedButtons.map((int index) {
                return buttonTexts[index];
              }).toList();
              sendChallengeFeedbackToServer(
                widget.day,
                widget.challengeStep,
                selectedEmotions,
              );
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
          const SizedBox(height: 10),
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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
