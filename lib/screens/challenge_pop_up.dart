import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:miri_app/models/challenge_store.dart';
import 'package:miri_app/services/challenge_services.dart';

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

//팝업창에서 최대 3개의 버튼을 선택하게하기
  Widget createButton(int index, {double width = 100.0, double height = 30.0}) {
    bool isSelected = selectedButtons.contains(index);
    double buttonContentSize = 13;
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
            style: TextStyle(
                fontSize: buttonContentSize, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

// 완료시 팝업창 UI
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    double iconText = 13.5;
    double buttonheight = 10;
    double width = 383;
    double footerTextSize = 16;
    double footerTextButtonSize = 12;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5.0,
      title: Text(
        '${widget.day}일차 수고했어요!',
        style: TextStyle(
            fontSize: iconSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '방금 챌린지를 마친 기분이 어떤지 알려줄래요?',
            style: TextStyle(
                fontSize: iconText,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: buttonheight),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: width,
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
          SizedBox(height: buttonheight),
          ElevatedButton(
            onPressed: () {
              List<String> selectedEmotions = selectedButtons.map((int index) {
                return buttonTexts[index];
              }).toList();
              sendChallengeFeedbackToServer(
                  selectedEmotions, _storage, context);
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
            child: Text(
              '완료',
              style: TextStyle(
                  fontSize: footerTextSize, fontWeight: FontWeight.bold),
            ),
          ),
          // const SizedBox(height: 10),
          TextButton(
            child: Text(
              '안할래요',
              style: TextStyle(
                fontSize: footerTextButtonSize,
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

//성공적인 감정전달 시
class ChallengeCompleteDialog extends StatelessWidget {
  const ChallengeCompleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '완료되었습니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '챌린지가 성공적으로 완료되었습니다!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        SizedBox(
          width: 140,
          height: 35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff6B42F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "확인",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // 성공 대화 상자 닫기
              Navigator.of(context).pop(); // 도전 팝업 닫기
              Navigator.of(context).pushReplacementNamed('/start');
            },
          ),
        ),
      ],
    );
  }
}
