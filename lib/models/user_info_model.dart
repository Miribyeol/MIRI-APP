class UserNickname {
  final bool success;
  final String message;
  final UserNicknameResult? result;

  UserNickname({
    required this.success,
    required this.message,
    this.result,
  });

  factory UserNickname.fromJson(Map<String, dynamic> json) {
    return UserNickname(
      success: json['success'],
      message: json['message'],
      result: json['result'] != null
          ? UserNicknameResult.fromJson(json['result'])
          : null,
    );
  }
}

class UserNicknameResult {
  final String nickname;

  UserNicknameResult({
    required this.nickname,
  });

  factory UserNicknameResult.fromJson(Map<String, dynamic> json) {
    return UserNicknameResult(
      nickname: json['nickname'],
    );
  }
}
