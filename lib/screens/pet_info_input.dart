import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pet_input_model.dart';

class PetInfoInputScreen extends StatefulWidget {
  const PetInfoInputScreen({Key? key}) : super(key: key);

  @override
  _PetInfoInputScreenState createState() => _PetInfoInputScreenState();
}

class _PetInfoInputScreenState extends State<PetInfoInputScreen> {
  String? name;
  String? species;
  String? birthday;
  String? deathday;

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
          birthday: birthday!,
          deathday: deathday!,
        );

        var url = Uri.parse('http://203.250.32.29:3000/pet');
        var response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken', // 토큰값을 헤더에 넣어서 전송
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Stack(
        children: [
          const Positioned(
            top: 130.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '반려동물의 정보를 알려주세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 230.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    DropdownMenuItem(value: 'Dog', child: Text('Dog')),
                    DropdownMenuItem(value: '고양이', child: Text('고양이')),
                    DropdownMenuItem(value: '햄스터', child: Text('햄찌')),
                    DropdownMenuItem(value: '앵무새', child: Text('앵무새')),
                    DropdownMenuItem(value: '고슴도치', child: Text('고슴도치')),
                    DropdownMenuItem(value: '물고기', child: Text('물고기')),
                    DropdownMenuItem(value: '조류', child: Text('조류')),
                    DropdownMenuItem(value: '파충류', child: Text('파충류')),
                    DropdownMenuItem(value: '그 외', child: Text('그 외')),
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
                const Text(
                  '반려동물 출생일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        birthday = pickedDate.toString();
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                  ),
                  controller: TextEditingController(text: birthday),
                ),
                const SizedBox(height: 35.0),
                const Text(
                  '반려동물 사망일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        deathday = pickedDate.toString();
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                  ),
                  controller: TextEditingController(text: deathday),
                ),
                const SizedBox(height: 35.0),
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
        ],
      ),
    );
  }
}
