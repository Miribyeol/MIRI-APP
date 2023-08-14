import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CheckTokenPage extends StatefulWidget {
  const CheckTokenPage({super.key});

  @override
  CheckTokenPageState createState() => CheckTokenPageState();
}

class CheckTokenPageState extends State<CheckTokenPage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    autoLogin(context);
  }

  Future<String?> getStoredToken() async {
    return await _secureStorage.read(key: 'jwtToken');
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwtToken', value: token);
  }

  Future<void> autoLogin(BuildContext context) async {
    final jwtToken = await getStoredToken();
    print(jwtToken);

    if (jwtToken != null) {
      final response = await http.post(
        Uri.parse('http://192.168.200.192:3000/auth/check'),
        headers: {'Authorization': 'Bearer $jwtToken'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/start'); // 홈 화면으로 이동
      } else if (response.statusCode == 401) {
        Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
