import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miri_app/screens/challenge.dart';
import 'package:miri_app/services/challenge_services.dart';
import '../widgets/challenge_list_widgets.dart';

class ChallengeListScreen extends StatefulWidget {
  const ChallengeListScreen({Key? key});

  @override
  ChallengeListScreenState createState() => ChallengeListScreenState();
}

class ChallengeListScreenState extends State<ChallengeListScreen> {
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

  void onChallengeDayPressed(int day) {
    if (challengeStep.contains(day + 1)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: const Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 10),
              child: Text(
                "이미 완료한 챌린지입니다",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
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
                    backgroundColor: const Color(0xff6B42F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
    } else if (day + 1 >
        (challengeStep.isNotEmpty ? challengeStep.last + 1 : 1)) {
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
                  fontSize: 18.0,
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
                    backgroundColor: const Color(0xff6B42F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
          builder: (context) => ChallengPage(day: day + 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121824),
      body: ChallengeListWidget(
        challengeStep: challengeStep,
        onChallengeDayPressed: onChallengeDayPressed,
      ),
    );
  }
}
