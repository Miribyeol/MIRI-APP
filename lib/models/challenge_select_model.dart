class EmotionData {
  final List<String> emotions;

  EmotionData(this.emotions);

  Map<String, dynamic> toJson() {
    return {
      'emotions': emotions,
    };
  }
}
