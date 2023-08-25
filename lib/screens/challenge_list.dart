import 'package:flutter/material.dart';
import 'package:miri_app/screens/challenge.dart';

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
          flexibleSpace: const FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 16.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '미리별 챌린지',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChallengPage(day: index + 1),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff6B42F8)),
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
