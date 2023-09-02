import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/start.dart';
// import 'screens/challenge.dart';
import 'screens/challenge_list.dart';
import 'screens/ai_onboarding.dart';
import 'screens/pet_charnel.dart';
import 'screens/login.dart';
import 'screens/pet_info_input.dart';
import 'screens/story.dart';
import 'screens/ai_consulting.dart';
import 'screens/onboarding.dart';
import 'screens/mypage_my_info.dart';
import 'screens/mypage_pet_info.dart';
import 'screens/mypage.dart';
import 'services/kakao_login.dart';
import 'screens/miri_station.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:provider/provider.dart';
// import 'route.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_APP_KEY"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    final KakaoLoginService kakaoLogin = KakaoLoginService();

    return MaterialApp(
      // onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Widgets',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: FutureBuilder(
        future: authHelper.checkKakaoLoginStatus(), // AuthHelper의 함수 호출
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
      // home:OnboardingScreen();
      routes: {
        '/login': (context) => LoginScreen(kakaoLoginService: kakaoLogin),
        '/start': (context) => const StartScreen(),
        '/challenge_list': (context) => const ChallengeListScreen(),
        '/ai_onboarding': (context) => const AIOnboardingScreen(),
        '/pet_charnel': (context) =>
            const PetCharnelScreen(), // Modified to 'PetCharnelScreen'
        '/pet_info_input': (context) => const PetInfoInputScreen(),
        '/story': (context) => const StoryScreen(),
        '/ai_consulting': (context) => const AIConsultingScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/mypage_my_info': (context) => const InformationScreen(),
        '/mypage_pet_info': (context) => const AnimalScreen(),
        '/mypage': (context) => MypageScreen(),
        '/miri_station': (context) => const MiriStationScreen(),
        // '/challenge': (context) {
        //   final Map<String, dynamic> args = ModalRoute.of(context)!
        //       .settings
        //       .arguments as Map<String, dynamic>;
        //   return ChallengPage(day: args['day']);
        // },
      },
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
