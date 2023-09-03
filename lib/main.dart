import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:miri_app/screens/onboarding.dart';
import 'package:miri_app/widgets/logo_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'services/kakao_login_service.dart';
import 'routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_APP_KEY"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});
  final AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    final KakaoLoginService kakaoLogin = KakaoLoginService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: FutureBuilder(
        future: authHelper.checkKakaoLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return const LogoScreen();
            } else {
              return const OnboardingScreen();
            }
          }
        },
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', ''),
      ],
    );
  }
}
