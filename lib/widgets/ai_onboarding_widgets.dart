import 'package:flutter/material.dart';

class AIOnboardingWidget extends StatelessWidget {
  const AIOnboardingWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    double titleSize = 28;
    double width = 200;
    double height = 200;
    double contentSize = 18;
    double textSize = 16;
    double buttonWidth = 20;
    double charTextTop = 60;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonSize = 18;

    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '별이와 대화하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Image.asset(
                    'assets/icon/star.png',
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    '별이는 상담을 도와주는 AI의 이름으로\n'
                    '별이와의 대화를 통해 고민과 어려움을\n'
                    '해결하는 동반자가 되어 줄 거에요 !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: contentSize,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: charTextTop,
            left: buttonWidth,
            right: buttonWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 알림창 띄우기
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white, // 알림창 배경색 흰색으로 설정
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // 모서리 둥글게 설정
                          ), // 글자 굵기 bold로 설정
                          content: Text(
                            '앗..! 죄송해요 아직 개발중이에요..!',
                            style: TextStyle(
                              color: Colors.black, // 텍스트 글자색 검정으로 설정
                              fontSize: textSize,
                              fontWeight: FontWeight.bold,
                              height: 2,
                            ),
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                // 알림창 닫기
                                Navigator.of(context).pop();
                                // 메인 화면으로 이동
                                Navigator.pushNamed(context, '/start');
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF6B42F8), // 확인 버튼 배경색 설정
                                minimumSize: Size(260, 30), // 확인 버튼 가로 길이 설정
                              ),
                              child: const Text(
                                '확인',
                                style: TextStyle(
                                  color: Colors.white, // 버튼 글자색 흰색으로 설정
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42F8),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: buttonSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
