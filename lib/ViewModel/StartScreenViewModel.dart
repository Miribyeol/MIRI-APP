import 'package:flutter/material.dart';
import '../models/main_emo_model.dart';
import '../services/start_api_service.dart';

class StartScreenViewModel extends ChangeNotifier {
  int challengerStep;
  List<Emotion> emotions;
  List<Post> posts;

  StartScreenViewModel({
    required this.challengerStep,
    required this.emotions,
    required this.posts,
  });

  // StartScreenViewModel 업데이트 메서드
  void updateViewModel({
    required int challengerStep,
    required List<Emotion> emotions,
    required List<Post> posts,
  }) {
    this.challengerStep = challengerStep;
    this.emotions = emotions;
    this.posts = posts;
    notifyListeners();
  }

  final ApiService _apiService = ApiService();

  Future<void> fetchDataFromServer() async {
    final result = await _apiService.fetchDataFromServer();
    if (result != null && result.containsKey('result')) {
      // Emotions 데이터 업데이트
      emotions = (result['result']['emotions'] as List)
          .map((item) => Emotion(
                emotion: item['emotion'].toString(),
                count: item['count'] as int,
              ))
          .toList();

      // Posts 데이터 업데이트
      posts = List<Map<String, dynamic>>.from(result['result']['posts'])
          .map((item) => Post(
                title: item['title'],
                content: item['content'],
                author: item['author'],
              ))
          .toList();

      // challengerStep 데이터 업데이트
      challengerStep = result['result']['challengerStep'] ?? 0;

      // UI에 변경 사항 알림
      notifyListeners();
    }
  }
}
