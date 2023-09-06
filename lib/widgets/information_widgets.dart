import 'package:flutter/material.dart';

import '../services/mypage_my_service.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  final ApiService _apiService = ApiService();
  late TextEditingController _nicknameController;
  String? userNickname;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();
    fetchUserNickname();
  }

  Future<void> fetchUserNickname() async {
    var result = await _apiService.fetchUserNickname();
    if (result['success']) {
      userNickname = result['nickname'];
      _nicknameController.text = userNickname ?? '';
    } else {
      print('Failed to fetch user nickname: ${result['error']}');
    }
  }

  Future<void> updateUserNickname() async {
    try {
      var newNickname = _nicknameController.text;
      var result = await _apiService.updateUserNickname(newNickname);
      if (result['success']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "닉네임이 변경되었습니다 :)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B42F8),
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    fetchUserNickname();
                  },
                  child: const Text(
                    "닫기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to update user nickname: ${result['error']}');
      }
    } catch (error) {
      print('Failed to update user nickname: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonHeight = screenHeight * 0.13;
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.07,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
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
              SizedBox(height: buttonHeight * 0.2),
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xFF1F2839),
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            ],
          ),
        ),
        Positioned(
          bottom: buttonHeight * 0.3,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          child: ElevatedButton(
            onPressed: () {
              updateUserNickname();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B42F8),
              minimumSize: Size(double.infinity, buttonHeight * 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
