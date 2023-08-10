import 'package:flutter/material.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({super.key});

  @override
  AnimalScreenState createState() => AnimalScreenState();
}

class AnimalScreenState extends State<AnimalScreen> {
  DateTime? _pickedBirthDate;
  DateTime? _pickedDeathDate;

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (isBirthDate) {
          _pickedBirthDate = pickedDate;
        } else {
          _pickedDeathDate = pickedDate;
        }
      });
    }
  }

  Widget _buildDateSelector(bool isBirthDate) {
    final pickedDate = isBirthDate ? _pickedBirthDate : _pickedDeathDate;
    // final labelText = isBirthDate ? '출생일' : '사망일';

    return InkWell(
      onTap: () => _selectDate(context, isBirthDate),
      child: InputDecorator(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFF1F2839),
          border: InputBorder.none,
        ),
        child: Text(
          pickedDate != null
              ? "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}"
              : "선택하세요",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // 여백 추가
        child: Text(
          title,
          style: const TextStyle(
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
        title: const Text('반려동물 정보 관리'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF6B42F8),
      ),
      backgroundColor: const Color(0xFF121824),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),
            _buildSectionTitle('닉네임'),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Handle the pet name input
              },
            ),
            const SizedBox(height: 40.0),
            _buildSectionTitle('반려동물 출생일'),
            const SizedBox(height: 20.0),
            _buildDateSelector(true),
            const SizedBox(height: 40.0),
            _buildSectionTitle('반려동물 사망일'),
            const SizedBox(height: 20.0),
            _buildDateSelector(false),
            const SizedBox(height: 40.0),
            _buildSectionTitle('반려동물 사진 업로드'),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1F2839),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    // Implement photo upload functionality here
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              onChanged: (value) {
                // Handle the pet photo input
              },
            ),
            const SizedBox(height: 180.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Container(
                          child: const Center(
                            child: Text(
                              "수정이 완료되었습니다:)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("닫기"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
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
}
