import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  InformationScreenState createState() => InformationScreenState();
}

class InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 정보 관리',
          style: TextStyle(fontWeight: FontWeight.bold), // 텍스트를 볼드체로 변경
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF6B42F8),
        //height: MediaQuery.of(context).size.height * 0.2,
      ),
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
            top: 50.0,
            //bottom: 820.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '닉네임',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                  ),
                  onChanged: (value) {
                    // Handle the pet name input
                  },
                ),
              ],
            ),
          ),
          const Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                /*children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/challenge_list');
                    },
                    child: const Text('챌린지'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ai_onboarding');
                    },
                    child: const Text('별이와 대화하기'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pet_charnel');
                    },
                    child: const Text('영원한 발자국'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '//mypage_my_info');
                    },
                    child: const Text('마이페이지'),
                  ),
                ],*/
              ),
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext con) {
                    return AlertDialog(
                      //title: const Text("수정이 완료되었습니다:)"),

                      content: SingleChildScrollView(
                        child: Container(
                          width: 335,
                          height: 100,
                          child: const Center(
                            child: Text(
                              "수정이 완료되었습니다 :)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              //style: TextStyle(color:Colors.black),
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,

                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF6B42F8), //Color(0xFF6B42F8)
                            minimumSize: const Size(double.infinity,
                                50), // Set the width and height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the border radius here
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Center(
                            child: Text(
                              "닫기",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8), //Color(0xFF6B42F8)
                minimumSize: const Size(double.infinity,
                    50), // Set the width and height of the button
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius here
                ),
              ),
              child: const Text(
                '변경하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
