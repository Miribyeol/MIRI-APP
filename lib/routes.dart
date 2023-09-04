import 'package:flutter/material.dart';
import 'package:miri_app/services/kakao_login_service.dart';
import 'screens/start.dart';
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
import 'screens/miri_station.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen(kakaoLoginService: KakaoLoginService()));
      case '/start':
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case '/challenge_list':
        return MaterialPageRoute(builder: (_) => const ChallengeListScreen());
      case '/ai_onboarding':
        return MaterialPageRoute(builder: (_) => const AIOnboardingScreen());
      case '/pet_charnel':
        return MaterialPageRoute(builder: (_) => const PetCharnelScreen());
      case '/pet_info_input':
        return MaterialPageRoute(builder: (_) => const PetInfoInputScreen());
      case '/story':
        return MaterialPageRoute(builder: (_) => const StoryScreen());
      case '/ai_consulting':
        return MaterialPageRoute(builder: (_) => const AIConsultingScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case '/mypage_my_info':
        return MaterialPageRoute(builder: (_) => const InformationScreen());
      case '/mypage_pet_info':
        return MaterialPageRoute(builder: (_) => const AnimalScreen());
      case '/mypage':
        return MaterialPageRoute(builder: (_) => const MypageScreen());
      case '/miri_station':
        return MaterialPageRoute(builder: (_) => const MiriStationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
