import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miri_app/screens/challenge.dart';
import 'package:miri_app/services/challenge_services.dart';

//챌린지 목록 시작
class ChallengeListScreen extends StatefulWidget {
  const ChallengeListScreen({super.key});

  @override
  ChallengeListScreenState createState() => ChallengeListScreenState();
}

//챌린지 목록상태 불러오기 및 확인
class ChallengeListScreenState extends State<ChallengeListScreen> {
  List<bool> daysCompleted = List.filled(14, false);
  List<int> challengeStep = [];
  FlutterSecureStorage storage = const FlutterSecureStorage();

  void loadDays() async {
    List<int>? result = await loadChallengeStatusFromServer(storage);
    if (result != null) {
      setState(() {
        challengeStep = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDays();
  }

  //챌린지 리스트 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121824),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(left: 16.0),
            color: const Color(0xFF121824),
            child: const Column(
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
          backgroundColor: const Color(0xFF121824),
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  content: const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "이미 완료한 챌린지입니다",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: <Widget>[
                                    SizedBox(
                                      width: 140,
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff6B42F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "확인",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
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
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  content: const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "이전 챌린지를 완료하지\n않았습니다",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: <Widget>[
                                    SizedBox(
                                      width: 140,
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff6B42F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "확인",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
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
                                  ? const Color(0xff1F2839)
                                  // 이전 챌린지를 완료하지 않은 경우 빨간색
                                  : (index + 1 >
                                          (challengeStep.isNotEmpty
                                              ? challengeStep.last + 1
                                              : 1))
                                      ? const Color(0xff1F2839)
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
