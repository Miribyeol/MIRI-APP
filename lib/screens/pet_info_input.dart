import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Cupertino 패키지 추가
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/pet_input_model.dart';

class PetInfoInputScreen extends StatefulWidget {
  const PetInfoInputScreen({Key? key}) : super(key: key);

  @override
  _PetInfoInputScreenState createState() => _PetInfoInputScreenState();
}

class _PetInfoInputScreenState extends State<PetInfoInputScreen> {
  String? name;
  String? species;
  DateTime? birthday;
  DateTime? deathday;

  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  Future<void> registerPetInfo() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        if (name == null ||
            species == null ||
            birthday == null ||
            deathday == null) {
          print('반려동물 정보 등록 실패: 필수 정보가 누락되었습니다.');
          return;
        }

        PetInput petInfo = PetInput(
          name: name!,
          species: species!,
          birthday: birthday!.toLocal().toString(), // 날짜를 문자열로 변환
          deathday: deathday!.toLocal().toString(), // 날짜를 문자열로 변환
        );
        var apiUrl = dotenv.env['API_URL'];
        var url = Uri.parse('$apiUrl/pet');
        var response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(petInfo.toJson()),
        );

        if (response.statusCode == 201) {
          print('반려동물 정보 등록 성공');

          Navigator.pushReplacementNamed(context, '/start');
        } else {
          print('반려동물 정보 등록 실패: ${response.statusCode}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('반려동물 정보 등록 실패'),
                content: const Text('반려동물 정보 등록에 실패하였습니다.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        print('저장된 토큰 없음');
      }
    } catch (error) {
      print('반려동물 정보 등록 오류: $error');
    }
  }

  Widget _buildDateSelector(
    String labelText,
    DateTime? selectedDate,
    Function(DateTime?) onDateSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15.0),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDate ?? DateTime.now(),
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        onDateSelected(newDateTime);
                      },
                      backgroundColor: const Color(0xFF121824),
                    ),
                  ),
                );
              },
            );

            if (pickedDate != null) {
              // 날짜를 선택한 경우에만 CupertinoDatePicker를 닫습니다.
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F2839),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16.0),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              child: Text(
                selectedDate != null
                    ? "${selectedDate.toLocal().year}년 ${selectedDate.toLocal().month}월 ${selectedDate.toLocal().day}일"
                    : "날짜를 선택하세요",
              ),
            ),
          ),
        ),
        const SizedBox(height: 35.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      // appBar: AppBar(
      //   title: const Text('반려동물 정보 등록',
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //       )),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   backgroundColor: const Color(0xFF121824),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100.0),
              Center(
                child: const Text(
                  '반려동물의 정보를 알려주세요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100.0),
              const Text(
                '반려동물 종류',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              DropdownButtonFormField<String>(
                value: species,
                items: const [
                  // ... (기존의 항목들을 그대로 유지)
                ],
                onChanged: (value) {
                  setState(() {
                    species = value;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xFF1F2839),
                  filled: true,
                ),
              ),
              const SizedBox(height: 35.0),
              const Text(
                '반려동물 이름',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xFF1F2839),
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              const SizedBox(height: 35.0),
              _buildDateSelector(
                '반려동물 출생일',
                birthday,
                (pickedDate) {
                  setState(() {
                    birthday = pickedDate;
                  });
                },
              ),
              _buildDateSelector(
                '반려동물 사망일',
                deathday,
                (pickedDate) {
                  setState(() {
                    deathday = pickedDate;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  registerPetInfo();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B42F8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  '완료',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
