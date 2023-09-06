import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/mypage_widgets.dart';
// import '../widgets/mypage_widgets.dart';

class MypageScreen extends StatelessWidget {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  const MypageScreen({Key? key});

  Future<void> _logout(BuildContext context) async {
    await _storage.delete(key: 'jwt_token');
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return MypageWidget(logoutFunction: _logout);
  }
}
