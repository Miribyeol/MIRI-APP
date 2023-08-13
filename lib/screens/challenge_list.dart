import 'package:flutter/material.dart';
import 'package:miri_app/screens/challenge.dart';
// import 'package:http/http.dart' as http;

// class StartScreen extends StatefulWidget {
//   @override
//   _StartScreenState createState() => _StartScreenState();
// }

// void main() {
//   runApp(const MaterialApp(
//     home: ChallengeListScreen(),
//   ));
// }

class ChallengeListScreen extends StatefulWidget {
  const ChallengeListScreen({super.key});

  @override
  ChallengeListScreenState createState() => ChallengeListScreenState();
}

class ChallengeListScreenState extends State<ChallengeListScreen> {
  List<bool> daysCompleted = List.filled(14, false);

  @override
  void initState() {
    super.initState();
    //loadDays();
  }
//저장된Day를 불러오기
  //loadDays() async {
  // try {
  //   final response = await http.get(Uri.parse('https://your-server.com/api/days'));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> daysData = json.decode(response.body);

  //     // 응답에서 일자별 완료 여부를 가져와 daysCompleted 리스트에 저장
  //     for (int i = 0; i < daysData.length; i++) {
  //       daysCompleted[i] = daysData[i]['completed']; // 서버 응답에 맞게 조정
  //     }

  //     // UI 업데이트
  //     setState(() {});
  //   } else {
  //     // 서버 응답 오류 처리
  //     print('Failed to load days.');
  //   }
  // } catch (e) {
  //   // 예외 처리
  //   print('An error occurred while fetching days: $e');
  // }
  // }

  //챌린지 리스트 UI
  @override
  Widget build(BuildContext context) {
    const TextStyle customStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    return Scaffold(
      backgroundColor: const Color(0xFF3D4353),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                '챌린지',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 10),
              const Text(
                '14일동안 미션을 수행해보아요',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 20),
              ...List.generate(14, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    width: 1000,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChallengPage(day: index + 1),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff6B42F8)),
                        //daysCompleted[index] ? const Color(0xff6B42F8) : Colors.grey),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Day ${index + 1}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
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
