import 'package:flutter/material.dart';
import 'package:miri_app/screens/miri_station_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:miri_app/widgets/miri_station_widgets.dart';

class MiriStationScreen extends StatefulWidget {
  const MiriStationScreen({Key? key}) : super(key: key);

  @override
  _MiriStationScreenState createState() => _MiriStationScreenState();
}

class _MiriStationScreenState extends State<MiriStationScreen> {
  bool showOnboarding = true;
  double offsetY = 0;
  String currentImagePath = 'assets/image/letter_2.png';
  String? backgroundImagePath;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  _checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seenOnboarding') ?? false);

    if (seen) {
      setState(() {
        showOnboarding = false;
      });
    } else {
      await prefs.setBool('seenOnboarding', true);
    }
  }

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
          if (backgroundImagePath != null)
            Positioned.fill(
              child: Image.asset(
                backgroundImagePath!,
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
                  // const Text(
                  //   '미리별 정거장',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 28.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80 - offsetY,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  // offsetY에 드래그 값을 추가합니다.
                  offsetY += details.delta.dy;

                  // offsetY 값을 0에서 20 사이로 제한합니다.
                  if (offsetY > 0) {
                    offsetY = 0;
                  } else if (offsetY < -250) {
                    offsetY = -250;
                  }

                  // offsetY가 20에 도달했을 때와 이미지 경로가 'assets/image/letter_1.png'일 때
                  if (offsetY == -250 &&
                      currentImagePath == 'assets/image/letter_1.png') {
                    currentImagePath = 'assets/image/letter_2.png';
                    offsetY = 0;
                    _showSuccessDialog(context);
                  }
                });
              },
              onTap: () {
                setState(() {
                  if (currentImagePath == 'assets/image/letter_2.png') {
                    currentImagePath = 'assets/image/letter_3.png';
                    letterTextDialog(context, () {
                      setState(() {
                        currentImagePath = 'assets/image/letter_1.png';
                        backgroundImagePath = 'assets/image/post_1.png';
                      });
                    });
                  } else {
                    currentImagePath = 'assets/image/letter_1.png';
                    backgroundImagePath = null;
                  }
                });
              },
              child: Image.asset(
                currentImagePath,
                width: 600.0,
                height: 500.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSuccessDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('작성하신 편지가'),
        content: const Text('미리별로 보내졌습니다!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 성공 대화 상자 닫기
              Navigator.of(context).pop(); // 도전 팝업 닫기
              Navigator.of(context).pushReplacementNamed('/start');
            },
            child: const Text('확인'),
          ),
        ],
      );
    },
  );
}
