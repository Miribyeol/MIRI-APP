import 'package:flutter/material.dart';
import 'package:miri_app/screens/story.dart';

class PetInfoInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121824),
      body: Stack(
        children: [
          Positioned(
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
                // Pet Type Selection (Dropdown)
                Text(
                  '반려동물 종류',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(child: Text('강아지'), value: 'Dog'),
                    DropdownMenuItem(child: Text('고양이'), value: 'Cat'),
                    DropdownMenuItem(child: Text('햄찌'), value: 'Hamster'),
                    DropdownMenuItem(child: Text('미어캣'), value: 'Meerkat'),
                  ],
                  onChanged: (value) {
                    // Handle the selected pet type
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                  ),
                ),
                SizedBox(height: 35.0),
                // Pet Name (Text Field)
                Text(
                  '반려동물 이름',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
                  ),
                  onChanged: (value) {
                    // Handle the pet name input
                  },
                ),
                SizedBox(height: 35.0),
                // Pet Birth Date (Date Picker)
                Text(
                  '반려동물 출생일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      // Handle the selected birth date
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFF1F2839),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
                // Pet Death Date (Date Picker)
                Text(
                  '반려동물 사망일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      // Handle the selected death date
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFF1F2839),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
                // Pet Photo (Text Field)
                Text(
                  '반려동물 사진 업로드',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xFF1F2839),
                    filled: true,
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
                SizedBox(height: 35.0),
                // Complete Button
                ElevatedButton(
                  onPressed: () {
                    // Handle the complete button press to proceed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoryScreen()),
                    );
                  },
                  child: Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6B42F8),
                    minimumSize: Size(double.infinity,
                        50), // Set the width and height of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius here
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
