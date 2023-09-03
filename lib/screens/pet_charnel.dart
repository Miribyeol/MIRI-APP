import 'package:flutter/material.dart';
import '../services/pet_charnel_service.dart'; // Import the ApiService

class PetCharnelScreen extends StatefulWidget {
  const PetCharnelScreen({Key? key}) : super(key: key);

  @override
  _PetCharnelScreenState createState() => _PetCharnelScreenState();
}

class _PetCharnelScreenState extends State<PetCharnelScreen> {
  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  String? petName = '';
  String? petBirthDate = '';
  String? petDeathDate = '';

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
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    width: 281.0,
                    height: 440.0,
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
                            child: Image.asset(
                              'assets/image/common-4.jpeg',
                              width: 210.0,
                              height: 247.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            petName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
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
