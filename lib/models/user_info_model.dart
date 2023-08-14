class UserNickname {
  final String nickname;

  UserNickname({
    required this.nickname,
  });

  factory UserNickname.fromJson(Map<String, dynamic> json) {
    return UserNickname(
      nickname: json['nickname'],
    );
  }
}
