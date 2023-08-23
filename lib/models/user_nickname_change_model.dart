class UserNicknameChange {
  final String nickname;

  UserNicknameChange({
    required this.nickname,
  });

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
    };
  }
}
