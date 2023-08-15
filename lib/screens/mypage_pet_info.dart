import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({super.key});

  @override
  AnimalScreenState createState() => AnimalScreenState();
}

class AnimalScreenState extends State<AnimalScreen> {
  DateTime? _pickedBirthDate;
  DateTime? _pickedDeathDate;

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
        padding: const EdgeInsets.only(bottom: 8.0), // 여백 추가
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
        //padding()
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),
            _buildSectionTitle('닉네임'),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF1F2839),
                border: OutlineInputBorder(
                  // OutlineInputBorder 사용
                  borderRadius: BorderRadius.circular(10.0), // 둥글기 10 설정
                  borderSide: BorderSide.none, // 테두리 선을 없애기 위해 사용
                ),
              ),
              onChanged: (value) {
                // Handle the pet name input
              },
            ),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 종류'),
            const SizedBox(height: 20.0),
            CustomDropdownFormField(
              onChanged: (value) {
                // Handle the selected pet type
              },
            ),
            const SizedBox(height: 20.0),
            _buildSectionTitle('반려동물 출생일'),
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
            Positioned(
              bottom: 40.0,
              left: 20.0,
              right: 20.0,
              child: ElevatedButton(
                onPressed: () {
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
                                //style: TextStyle(color:Colors.black),
                              ),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF6B42F8), //Color(0xFF6B42F8)
                              minimumSize: const Size(double.infinity,
                                  50), // Set the width and height of the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the border radius here
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
            ),
          ],
        ),
      ),
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

  // itemBuilder 메서드를 클래스 내부에 정의
  DropdownMenuItem<String> itemBuilder(String value, String label) {
    return DropdownMenuItem(
      value: value,
      child: Container(
        width: double.infinity, // 넓이를 DropdownButtonFormField에 맞게 확장
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
