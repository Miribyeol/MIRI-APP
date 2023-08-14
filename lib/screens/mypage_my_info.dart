import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import '../models/user_info_model.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  InformationScreenState createState() => InformationScreenState();
}

class InformationScreenState extends State<InformationScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();
// Initialize with an empty nickname
    fetchUserNickname();
  }

  Future<void> fetchUserNickname() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://192.168.200.192:3000/user');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken', // Include the token
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var userNickname = jsonResponse['nickname'];
          print('User nickname: $userNickname');
          setState(() {});
        } else {
          print('Failed to fetch user nickname: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error fetching user nickname: $error');
    }
  }

  Future<void> updateUserNickname() async {
    try {
      var newNickname = _nicknameController.text;
      var response = await http.put(
          Uri.parse('http://192.168.200.192:3000/user'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'nickname': newNickname}));

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text("수정이 완료되었습니다:)"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("닫기"),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to update user nickname: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to update user nickname: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 정보 관리',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF6B42F8),
      ),
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
            top: 50.0,
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
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                  ),
                  onChanged: (value) {
                    // Handle the nickname input
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                updateUserNickname();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8),
                minimumSize: const Size(double.infinity, 50),
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
      ),
    );
  }
}
