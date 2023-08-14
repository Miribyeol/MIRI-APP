class UserNicknameChange {
  final String nickname;

  UserNicknameChange({
    required this.nickname,
  });

  factory UserNicknameChange.fromJson(Map<String, dynamic> json) {
    return UserNicknameChange(
      nickname: json['nickname'],
    );
  }
}