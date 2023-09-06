import 'package:flutter/material.dart';
import 'package:miri_app/screens/miri_station_onboarding.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MiriStationScreen extends StatefulWidget {
  const MiriStationScreen({Key? key}) : super(key: key);

  @override
  _MiriStationScreenState createState() => _MiriStationScreenState();
}

class _MiriStationScreenState extends State<MiriStationScreen> {
  bool showOnboarding = true;

  @override
  void initState() {
    super.initState();
    // _checkOnboarding();
  }

  // _checkOnboarding() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool seen = (prefs.getBool('seenOnboarding') ?? false);

  //   if (seen) {
  //     setState(() {
  //       showOnboarding = false;
  //     });
  //   } else {
  //     await prefs.setBool('seenOnboarding', true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return showOnboarding
        ? MiriStationOnboarding(onCompleted: () {
            setState(() {
              showOnboarding = false;
            });
          })
        : _mainScreen();
  }

  Widget _mainScreen() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/blue_cosmos.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '미리별 정거장',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80.0),
                  Image.asset(
                    'assets/icon/star.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ai_consulting');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42F8),
                    minimumSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: 18.0,
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
