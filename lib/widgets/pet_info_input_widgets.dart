import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/pet_info_input_service.dart';

class PetInfoInputWidget extends StatefulWidget {
  const PetInfoInputWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PetInfoInputWidgetState createState() => _PetInfoInputWidgetState();
}

class _PetInfoInputWidgetState extends State<PetInfoInputWidget> {
  String? name;
  String? species;
  DateTime? birthday;
  DateTime? deathday;
  File? _selectedImage;

  ApiService apiService = ApiService(); // Create an instance of the ApiService

  @override
  void initState() {
    super.initState();
  }

  void registerPetInfo({
    required String name,
    required String species,
    required String birthday,
    required String deathday,
    String? filename,
  }) {
    if (name.isEmpty ||
        species.isEmpty ||
        birthday.isEmpty ||
        deathday.isEmpty) {
      print('반려동물 정보 등록 실패: 필수 정보가 누락되었습니다.');
      return;
    }

    apiService.registerPetInfo(
      name: name,
      species: species,
      birthday: birthday,
      deathday: deathday,
      filename: filename,
    );
  }

  void registerAndUploadImage() {
    if (_selectedImage != null) {
      apiService.uploadPetImage(_selectedImage!).then((result) {
        if (result['success']) {
          String uploadedFilename = result['filename'];

          registerPetInfo(
            name: name!,
            species: species!,
            birthday: birthday!.toLocal().toString(),
            deathday: deathday!.toLocal().toString(),
            filename: uploadedFilename,
          );
        } else {
          print('이미지 업로드 실패: ${result['error']}');
        }
      });
    } else {
      print('업로드할 이미지가 선택되지 않았습니다.');
    }
  }

  Widget _buildDateSelector(
    String labelText,
    DateTime? selectedDate,
    Function(DateTime?) onDateSelected,
  ) {
    double iconTop = 15.0;
    double height = 300;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: iconTop),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: height,
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
                fontSize: 16,
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
    double screenHeight = MediaQuery.of(context).size.height;
    double titleSize = 20;
    double contentSize = 18;
    double buttonHeight = screenHeight * 0.13;
    double textTop = 100;
    double contentText = 35;
    double iconTop = 15;
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: textTop),
              Center(
                child: Text(
                  '반려동물의 정보를 알려주세요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: textTop),
              Text(
                '반려동물 종류',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: contentSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: iconTop),
              DropdownButtonFormField<String>(
                value: species,
                items: const [
                  DropdownMenuItem(value: '강아지', child: Text('강아지')),
                  DropdownMenuItem(value: '고양이', child: Text('고양이')),
                  DropdownMenuItem(value: '햄스터', child: Text('햄스터')),
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
              SizedBox(height: contentText),
              Text(
                '반려동물 이름',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: contentSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: iconTop),
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
              SizedBox(height: contentText),
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
              const Text(
                '반려동물 사진 업로드',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: contentText),
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
                  ),
                  child: _selectedImage == null
                      ? Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50.0,
                          ),
                        )
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: contentText),
              ElevatedButton(
                onPressed: () {
                  registerAndUploadImage();
                  Navigator.pushNamed(context, '/story');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B42F8),
                  minimumSize: Size(double.infinity, buttonHeight * 0.5),
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
