import 'package:flutter/material.dart';
import '../services/pet_charnel_service.dart'; // Import the ApiService
// import 'dart:io';

class PetCharnelScreen extends StatefulWidget {
  const PetCharnelScreen({Key? key}) : super(key: key);

  @override
  _PetCharnelScreenState createState() => _PetCharnelScreenState();
}

class _PetCharnelScreenState extends State<PetCharnelScreen> {
  String baseUrl = "http://203.250.32.29:3000/pet/image/";
  String get fullImageUrl => baseUrl + (petImage ?? '');
  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  String? petName = '';
  String? petBirthDate = '';
  String? petDeathDate = '';
  String? petImage;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonTitleSize = 20;
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
          ),
          // Image and text
          Expanded(
            flex: 4,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: screenWidth * 0.7, //281.0
                    height: screenHeight * 0.53, //440.0
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                                    width: 210.0,
                                    height: 247.0,
                                  )
                                : Center(child: Text("이미지 없음")),
                          ),

                          SizedBox(height: buttonTitleSize * 0.5), //10.0
                          Text(
                            petName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: buttonTitleSize * 0.5), //10.0
                          Text(
                            '$petBirthDate ~ $petDeathDate',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Text positioned at the bottom
          Expanded(
            flex: 2,
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: Center(
                  child: Text(
                    '고마워, 햄찌.\n함께한 모든 순간들을 기억할게.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
