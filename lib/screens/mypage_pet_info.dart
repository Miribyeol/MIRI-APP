import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({super.key});

  @override
  AnimalScreenState createState() => AnimalScreenState();
}

class AnimalScreenState extends State<AnimalScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  DateTime? _pickedBirthDate;
  DateTime? _pickedDeathDate;

  String? petName = '';
  String? petSpecies = '';
  String? petBirthDate = '';
  String? petDeathDate = '';

  @override
  void initState() {
    super.initState();
    _pickedBirthDate = DateTime.now();
    _pickedDeathDate = DateTime.now();
    fetchPetInfo();
  }

  Future<void> fetchPetInfo() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://203.250.32.29:3000/pet');
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          setState(() {
            petName = jsonResponse['petInfo']['name'];
            petSpecies = jsonResponse['petInfo']['species'];
            petBirthDate = jsonResponse['petInfo']['birthday'];
            petDeathDate = jsonResponse['petInfo']['deathday'];
          });
        } else {
          print('Failed to fetch pet info: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error fetching pet info: $error');
    }
  }

  Future<DateTime?> _showCustomModal(
      BuildContext context, bool isBirthDate) async {
    return await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime? selectedDate;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 300,
            height: 350,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime date) {
                      selectedDate = date;
                    },
                    initialDateTime: DateTime.now(),
                    minimumYear: 2000,
                    maximumYear: DateTime.now().year,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedDate);
                  },
                  child: Text("OK"),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateSelector(bool isBirthDate) {
    final pickedDate = isBirthDate ? _pickedBirthDate : _pickedDeathDate;

    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await _showCustomModal(context, isBirthDate);
        if (selectedDate != null) {
          setState(() {
            if (isBirthDate) {
              _pickedBirthDate = selectedDate;
            } else {
              _pickedDeathDate = selectedDate;
            }
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF1F2839),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        child: Text(
          pickedDate != null
              ? "${pickedDate.year}년 ${pickedDate.month}월 ${pickedDate.day}일"
              : "선택하세요",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반려동물 정보 관리'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF6B42F8),
      ),
      backgroundColor: Color(0xFF121824),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('닉네임'),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  petName = value;
                });
              },
              initialValue: petName,
            ),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 종류'),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  petSpecies = value;
                });
              },
              initialValue: petSpecies,
            ),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 출생일'),
                        TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  petBirthDate = value;
                });
              },
              initialValue: petBirthDate,
            ),
            const SizedBox(height: 20.0),
            _buildDateSelector(true),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 사망일'),
            const SizedBox(height: 20.0),
            _buildDateSelector(false),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 사진 업로드'),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    // Implement photo upload functionality here
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              onChanged: (value) {
                // Handle the pet photo input
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await updatePetInfo();
                showUpdateDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6B42F8),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                '변경하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updatePetInfo() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://203.250.32.29:3000/pet');
        var response = await http.put(
          url,
          headers: {
            'Authorization': 'Bearer $storedToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': petName,
            'species': petSpecies,
            'birthday': petBirthDate,
            'deathday': petDeathDate,
          }),
        );

        if (response.statusCode != 200) {
          print('Failed to update pet info: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error updating pet info: $error');
    }
  }

  void showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              width: 335,
              height: 100,
              child: const Center(
                child: Text(
                  "수정이 완료되었습니다 :)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text(
                  "닫기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomDropdownFormField extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? initialValue;

  CustomDropdownFormField({
    Key? key,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  DropdownMenuItem<String> itemBuilder(String value, String label) {
    return DropdownMenuItem(
      value: value,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      isExpanded: true,
      items: [
        itemBuilder('Dog', '강아지'),
        itemBuilder('Cat', '고양이'),
        itemBuilder('Hamster', '햄찌'),
        itemBuilder('Meerkat', '미어캣'),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Color(0xFF1F2839),
        filled: true,
      ),
    );
  }
}
