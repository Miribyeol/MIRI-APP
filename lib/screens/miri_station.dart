import 'package:flutter/material.dart';
import 'package:miri_app/screens/miri_station_onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiriStationScreen extends StatefulWidget {
  const MiriStationScreen({Key? key}) : super(key: key);

  @override
  _MiriStationScreenState createState() => _MiriStationScreenState();
}

class _MiriStationScreenState extends State<MiriStationScreen> {
  final _textController = TextEditingController();
  bool showOnboarding = true;
  double offsetY = 0;
  String currentImagePath = 'assets/image/letter_2.png';
  String? backgroundImagePath;
  String? textFieldImagePath;
  bool showTextField = true;
  bool showButton = true;
  double imageYOffset = 10;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
    backgroundImagePath = 'assets/image/post_letter_1.png';
    textFieldImagePath = 'assets/image/letter_2.png';
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
                  SizedBox(
                    height: 30,
                  ),
                  if (showButton)
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              backgroundImagePath = 'assets/image/post_1.png';
                              textFieldImagePath = 'assets/image/letter_1.png';
                              showTextField = !showTextField;
                              showButton = false;
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset('assets/icon/star.png'),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Stack(
                      children: [
                        if (!showTextField)
                          Transform.translate(
                            offset: Offset(0, imageYOffset),
                            child: GestureDetector(
                              onVerticalDragUpdate: (details) {
                                setState(() {
                                  imageYOffset += details.delta.dy;
                                });
                              },
                              onVerticalDragEnd: (details) {
                                if (details.velocity.pixelsPerSecond.dy < 0) {
                                  _showSuccessDialog(context);
                                }
                              },
                              child: Image.asset(textFieldImagePath!),
                            ),
                          ),
                        if (showTextField)
                          TextField(
                            maxLines: 13,
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: '반려동물에게 편지를 작성해봐요',
                              hintStyle: TextStyle(color: Colors.black),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
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
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            '작성하신 편지가\n미리별로 보내졌습니다!',
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
              child: Text(
                "확인",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/start');
              },
            ),
          ),
        ],
      );
    },
  );
}
