class ChallengeStatusResponse {
  final bool success;
  final String message;
  final ChallengeStepData result;

  ChallengeStatusResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory ChallengeStatusResponse.fromJson(Map<String, dynamic> json) {
    return ChallengeStatusResponse(
      success: json['success'],
      message: json['message'],
      result: ChallengeStepData.fromJson(json['result']),
    );
  }
}

class ChallengeStepData {
  final int challengeStep;

  ChallengeStepData({required this.challengeStep});

  factory ChallengeStepData.fromJson(Map<String, dynamic> json) {
    return ChallengeStepData(
      challengeStep: json['challengeStep'],
    );
  }
}
