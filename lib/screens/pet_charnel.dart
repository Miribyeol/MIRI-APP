import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PetCharnelScreen extends StatefulWidget {
  const PetCharnelScreen({Key? key}) : super(key: key);

  @override
  _PetCharnelScreenState createState() => _PetCharnelScreenState();
}

class _PetCharnelScreenState extends State<PetCharnelScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? petName = '';
  String? petBirthDate = '';
  String? petDeathDate = '';

  @override
  void initState() {
    super.initState();
    fetchPetInfo();
  }

  Future<void> fetchPetInfo() async {
    try {
      String? storedToken = await _storage.read(key: 'jwt_token');
      if (storedToken != null) {
        var url = Uri.parse('http://203.250.32.29:3000/pet'); // API URL 수정
        var response = await http.get(url, headers: {
          'Authorization': 'Bearer $storedToken',
        });

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print('JSON Response: $jsonResponse');
          setState(() {
            petName = jsonResponse['result']['petInfo']['name'];
            petBirthDate = jsonResponse['result']['petInfo']['birthday'];
            petDeathDate = jsonResponse['result']['petInfo']['deathday'];
          });
        } else {
          print('Failed to fetch pet info: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error fetching pet info: $error');
    }
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '$petBirthDate ~ $petDeathDate',
                            style: TextStyle(
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
