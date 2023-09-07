import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/pet_info_model.dart';
import '../services/mypage_pet_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({Key? key}) : super(key: key);

  @override
  AnimalScreenState createState() => AnimalScreenState();
}

class AnimalScreenState extends State<AnimalScreen> {
  late String baseUrl;
  String get fullImageUrl => baseUrl + (petImage ?? '');
  final ApiService _apiService = ApiService();
  DateTime? _pickedBirthDate;
  DateTime? _pickedDeathDate;
  File? _selectedImage;
  String? petImage;
  String? petSpecies;

  final TextEditingController _nameController = TextEditingController();
  String? petName = '';
  // String? petSpecies;
  String? petBirthDate = '';
  String? petDeathDate = '';

  List<String> petSpeciesOptions = [
    '강아지',
    '고양이',
    '햄스터',
    '앵무새',
    '고슴도치',
    '물고기',
    '조류',
    '파충류',
    '그 외',
  ];

  @override
  void initState() {
    super.initState();
    baseUrl = "${dotenv.env['API_URL']}/pet/image/";
    fetchPetInfo();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> fetchPetInfo() async {
    var result = await _apiService.fetchPetInfo();
    if (result['success']) {
      PetInfo petInfo = result['petInfo'];
      setState(() {
        petName = petInfo.name;
        petSpecies = petInfo.species;
        petBirthDate = petInfo.birthday;
        petDeathDate = petInfo.deathday;
        _pickedBirthDate = DateTime.parse(petBirthDate!);
        _pickedDeathDate = DateTime.parse(petDeathDate!);
        _nameController.text = petName ?? '';
        petImage = petInfo.image;
      });
    } else {
      print('Failed to fetch pet info: ${result['error']}');
    }
  }

  Future<void> _updatePetInfo() async {
    print(petSpecies);
    String? uploadedFilename;
    if (_selectedImage != null) {
      // 이미지를 먼저 업로드
      var imageResult = await _apiService.uploadPetImage(_selectedImage!);
      if (!imageResult['success']) {
        print('이미지 업로드 실패: ${imageResult['error']}');
        return;
      }
      uploadedFilename = imageResult['filename'];
    } else {
      print('업로드할 이미지가 선택되지 않았습니다.');
      // 이미지가 선택되지 않았을 경우 fetchPetInfo로부터 가져온 petImage 사용
      // await fetchPetInfo();
      uploadedFilename = petImage;
    }
    var updatedPetInfo = PetInfo(
      name: petName ?? '',
      species: petSpecies ?? '',
      birthday: petBirthDate ?? '',
      deathday: petDeathDate ?? '',
      image: uploadedFilename ?? petImage,
    );

    var result = await _apiService.updatePetInfo(updatedPetInfo, null);
    if (result['success']) {
      PetInfo petInfo = result['petInfo'];
      setState(() {
        petName = petInfo.name;
        petSpecies = petInfo.species;
        petBirthDate = petInfo.birthday;
        petDeathDate = petInfo.deathday;
      });
      showUpdateDialog(true);
    } else {
      print('Failed to update pet info: ${result['error']}');
      showUpdateDialog(false);
    }
  }

  Future<DateTime?> _showCustomModal(
      BuildContext context, bool isBirthDate) async {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime? selectedDate;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: screenWidth,
            height: 250,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime date) {
                      selectedDate = date;
                    },
                    initialDateTime: DateTime.now(),
                    minimumYear: 1950,
                    maximumYear: DateTime.now().year,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedDate);
                  },
                  child: const Text("OK"),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double buttonTitleSize = 20;
    double buttonHeight = screenHeight * 0.13;
    return Scaffold(
      appBar: AppBar(
        title: const Text('반려동물 정보 관리',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('반려동물이름'),
            TextFormField(
              controller: _nameController, // 컨트롤러 연결
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1F2839),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                petName = value;
              },
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('반려동물 종류'),
            DropdownFormField(
              onChanged: (String? newValue) {
                setState(() {
                  petSpecies = newValue;
                });
              },
              initialValue: petSpecies,
              options: petSpeciesOptions,
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('반려동물 출생일'),
            _buildDateSelector(true),
            const SizedBox(height: 20),
            _buildSectionTitle('반려동물 사망일'),
            _buildDateSelector(false),
            const SizedBox(height: 20),
            _buildSectionTitle('반려동물 사진 업로드'),
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  _selectedImage = File(pickedFile.path);
                  setState(() {});
                } else {
                  print('사진 선택이 취소되었습니다.');
                }
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2839),
                  border: Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(
                      10.0), // ClipRRect와 동일한 효과를 주기 위해 추가
                ),
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : petImage != null
                        ? Image.network(
                            fullImageUrl,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _updatePetInfo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B42F8),
                minimumSize: Size(double.infinity, buttonHeight * 0.5),
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

  Widget _buildDateSelector(bool isBirthDate) {
    final pickedDate = isBirthDate ? _pickedBirthDate : _pickedDeathDate;

    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await _showCustomModal(context, isBirthDate);
        if (selectedDate != null) {
          setState(() {
            if (isBirthDate) {
              _pickedBirthDate = selectedDate;
              petBirthDate =
                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
            } else {
              _pickedDeathDate = selectedDate;
              petDeathDate =
                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
            }
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF1F2839),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        child: Text(
          pickedDate != null
              ? "${pickedDate.year}년 ${pickedDate.month}월 ${pickedDate.day}일"
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
        padding: const EdgeInsets.only(bottom: 8.0),
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

  void showUpdateDialog(bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        double buttonHeight = screenHeight * 0.13;
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
              width: 335, //335
              height: 110, //100
              child: Center(
                child: Text(
                  isSuccess ? "수정이 완료되었습니다 :)" : "수정에 실패했습니다 :(",
                  style: TextStyle(
                    color: isSuccess ? Colors.black : Colors.red,
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
                minimumSize: Size(double.infinity, buttonHeight * 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (true) {
                  // Navigate to the main screen
                  Navigator.of(context)
                      .pushReplacementNamed('/start'); // Replace current route
                }
              },
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

// ignore: must_be_immutable
class DropdownFormField extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  String? initialValue; // 초기 값 설정
  final List<String> options;

  DropdownFormField({
    Key? key,
    this.onChanged,
    this.initialValue,
    required this.options,
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
      items: options.map((value) => itemBuilder(value, value)).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color(0xFF1F2839),
        filled: true,
      ),
    );
  }
}
