import 'package:flutter/material.dart';
import 'package:miri_app/screens/challenge_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the routes
      routes: {
        '/': (context) => const ChallengPage(day: 1),
        '/challenge_list': (context) => const ChallengeListScreen(),
      },
    );
  }
}

class ChallengPage extends StatelessWidget {
  final int day;

  const ChallengPage({Key? key, required this.day}) : super(key: key);

  List<Widget> _challengeStory(int day) {
    switch (day) {
      case 1:
        return [
          const Icon(Icons.star),
          const SizedBox(height: 20),
          const Text('친구나 가족과의 만남'),
        ];
      case 2:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('물 마시기'),
        ];
      case 3:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('명상 및 호흡 운동'),
        ];
      case 4:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('음악 감상'),
        ];
      case 5:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('자기 사랑 연습'),
        ];
      case 6:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('긍정적인 인용구 모으기'),
        ];
      case 7:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('자기 선물'),
        ];
      case 8:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('봉사 활동'),
        ];
      case 9:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('웃음 요법'),
        ];
      case 10:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('사진 도전'),
        ];
      case 11:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('자연 치유'),
        ];
      case 12:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('일기 쓰기'),
        ];
      case 13:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('책 읽기'),
        ];
      case 14:
        return [
          const Icon(Icons.android),
          const SizedBox(height: 20),
          const Text('새로운 취미 시작'),
        ];
      default:
        return [
          const Icon(Icons.arrow_back_ios_new_sharp),
          const SizedBox(height: 20),
          const Text('그 외 내용'),
        ];
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Challenge Day $day'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
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
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Day $day',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('오늘 하루는 어떠셨나요?'),
                      ),
                      const SizedBox(
                        height: 30,
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
                color: const Color(0xff3a3b50),
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
                            child: const Text('목록으로'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff3a3b50)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChallengPopUp(
                                    day: day,
                                  );
                                },
                              );
                            },
                            child: const Text('완료'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF6B42F8)),
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
        ));
  }
}

class ChallengPopUp extends StatefulWidget {
  final int day;

  const ChallengPopUp({super.key, required this.day});

  @override
  ChallengPopUpState createState() => ChallengPopUpState();
}

class ChallengPopUpState extends State<ChallengPopUp> {
  List<bool> pressed = List.generate(17, (index) => false);

  Widget createButton(int index) {
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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              pressed[index] = !pressed[index];
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) || pressed[index]) {
                  return const Color(0xff6b42f8);
                }
                return const Color(0xff3d4353);
              },
            ),
          ),
          child: Text('# ${buttonTexts[index]}'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.day}일차 수고했어요!',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('방금 챌린지를 마친 기분이 어떤지 알려줄래요?'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(0),
              createButton(1),
              createButton(2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(3),
              createButton(4),
              createButton(5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(6),
              createButton(7),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(8),
              createButton(9),
              createButton(10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createButton(11),
              createButton(12),
              createButton(13),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/challenge_list');
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(520, 20)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF6B42F8)),
            ),
            child: const Text(
              '완료',
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            child: const Text('안할래요'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
