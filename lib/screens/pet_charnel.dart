import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/pet_charnel_service.dart';

class PetCharnelScreen extends StatefulWidget {
  const PetCharnelScreen({Key? key}) : super(key: key);

  @override
  _PetCharnelScreenState createState() => _PetCharnelScreenState();
}

class _PetCharnelScreenState extends State<PetCharnelScreen> {
  late String baseUrl;
  String get fullImageUrl => baseUrl + (petImage ?? '');
  final ApiService apiService = ApiService();

  String? petName = '';
  String? petBirthDate = '';
  String? petDeathDate = '';
  String? petImage;

  bool isBoxDecorationVisible = false;

  @override
  void initState() {
    super.initState();
    baseUrl = "${dotenv.env['API_URL']}/pet/image/";
    // 앱이 처음 실행되었는지 확인
    checkFirstRun();
    fetchPetInfo();
  }

  Future<void> fetchPetInfo() async {
    final petInfo = await apiService.fetchPetInfo();

    setState(() {
      petName = petInfo['petName'];
      petBirthDate = petInfo['petBirthDate'];
      petDeathDate = petInfo['petDeathDate'];
      petImage = petInfo['petImage'];
    });
  }

  // 앱이 처음 실행되었는지 확인하는 함수
  Future<void> checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true; // 처음 실행되었는지 여부 확인

    if (isFirstRun) {
      // 처음 실행되었으면 토스트 메시지 표시
      showToast();
      // isFirstRun 값을 false로 설정하여 다음 실행부터는 표시하지 않음
      prefs.setBool('isFirstRun', false);
    }
  }

  double boxDecorationHeight = 10.0;

  void toggleBoxDecoration() {
    setState(() {
      if (isBoxDecorationVisible) {
        boxDecorationHeight = 10.0;
      } else {
        boxDecorationHeight = MediaQuery.of(context).size.height * 0.6;
      }
      isBoxDecorationVisible = !isBoxDecorationVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonTitleSize = 20;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 배경 이미지
          Image.asset(
            'assets/image/pet_charnel.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                toggleBoxDecoration();
                // 화면 클릭 시 토스트 메시지 사라짐
                Fluttertoast.cancel();
              },
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity! > 0) {
                  toggleBoxDecoration();
                  // 화면 클릭 시 토스트 메시지 사라짐
                  Fluttertoast.cancel();
                } else if (details.primaryVelocity != null &&
                    details.primaryVelocity! < 0) {
                  toggleBoxDecoration();
                  // 화면 클릭 시 토스트 메시지 사라짐
                  Fluttertoast.cancel();
                }
              },
              child: AnimatedOpacity(
                opacity: isBoxDecorationVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: screenWidth * 0.73,
                  height: boxDecorationHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF121824),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: petImage != null
                              ? Image.network(
                                  fullImageUrl,
                                  width: 220.0,
                                  height: 200.0,
                                )
                              : const Center(child: Text("이미지 없음")),
                        ),
                        SizedBox(height: buttonTitleSize * 2),
                        Text(
                          petName ?? '',
                          style: const TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: buttonTitleSize * 0.5),
                        Text(
                          '$petBirthDate ~ $petDeathDate',
                          style: const TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: buttonTitleSize * 2),
                        const Text(
                          '고마웠어. \n너와 함께한 모든 순간들에게.',
                          style: TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 뒤로 가기 버튼
          Positioned(
            left: 10.0,
            top: 45.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // 토스트 메시지 표시 함수
  void showToast() {
    Fluttertoast.showToast(
      msg: "화면 클릭 시 나의 반려동물 정보가 보입니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Color(0xFF6B42F8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
