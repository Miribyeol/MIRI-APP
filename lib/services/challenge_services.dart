import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:miri_app/screens/challenge_pop_up.dart';

//챌린지 단계 받아오기
Future<List<int>?> loadChallengeStatusFromServer(
    FlutterSecureStorage storage) async {
  try {
    final storedToken = await storage.read(key: 'jwt_token');
    if (storedToken != null) {
      var apiUrl = dotenv.env['API_URL'];

      var url = Uri.parse('$apiUrl/main');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $storedToken',
          'Content-Type': 'application/json',
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int stepValue = data['result']['challengerStep'];
        print('challengeStep from server: $stepValue');
        return List.generate(stepValue, (index) => index + 1);
      } else {
        print(
            'Server returned an error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } else {
      print('Stored token is null.');
      return null;
    }
  } catch (e) {
    print('Error getting challenge status: $e');
    return null;
  }
}

//챌린지DAY 완료 여부 전송
Future<void> sendChallengeStatusToServer(
    int day, int challengeStep, FlutterSecureStorage storage) async {
  try {
    final storedToken = await storage.read(key: 'jwt_token');
    if (storedToken != null) {
      var apiUrl = dotenv.env['API_URL'];
      var url = Uri.parse('$apiUrl/challenge/status');

      var response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $storedToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'day': day.toString(),
          'challengeStep': challengeStep.toString(),
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending challenge status: $e');
  }
}

//감정 선택후 전송기능
Future<void> sendChallengeFeedbackToServer(List<String> emotions,
    FlutterSecureStorage storage, BuildContext context) async {
  try {
    if (emotions.isEmpty || emotions.length > 4) {
      print('최대 3개까지 선택하세요');
      return;
    }

    final storedToken = await storage.read(key: 'jwt_token');
    if (storedToken != null) {
      var apiUrl = dotenv.env['API_URL'];
      final url = Uri.parse('$apiUrl/emotion');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $storedToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'emotions': emotions,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (context) => const ChallengeCompleteDialog(),
        );
      } else if (response.statusCode == 400) {
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text('에러 발생'),
        //     content: Text('잘못된 요청입니다. 다시 시도해 주세요.'),
        //   ),
        // );
      }
    }
  } catch (e) {
    print('Error sending challenge feedback: $e');
  }
}
