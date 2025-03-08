// screens/pet_info_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetInfoScreen extends StatefulWidget {
  const PetInfoScreen({super.key});

  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedSex = 'Male';
  String selectedAge = 'Less than 1 year';
  Uint8List? photoBytes;

  // ฟังก์ชันเลือกภาพ
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        photoBytes = bytes;
      });
    }
  }

  // ฟังก์ชันบันทึกข้อมูลสัตว์เลี้ยง
  void savePetInfo() {
    final petData = {
      'name': nameController.text,
      'species': speciesController.text,
      'weight': weightController.text,
      'sex': selectedSex,
      'age': selectedAge,
      'photoBytes': photoBytes,
    };

    Navigator.pop(context, petData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name')),
            TextField(
                controller: speciesController,
                decoration: const InputDecoration(hintText: 'Species')),
            TextField(
                controller: weightController,
                decoration: const InputDecoration(hintText: 'Weight'),
                keyboardType: TextInputType.number),
            DropdownButton<String>(
              value: selectedSex,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSex = newValue!;
                });
              },
              items: ['Male', 'Female', 'Unknown'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedAge,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAge = newValue!;
                });
              },
              items: [
                'Less than 1 year',
                '1 year',
                '2 years',
                '3 year',
                '4 years',
                '5 year',
                '6 years',
                'Over 7 years'
              ].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            photoBytes == null
                ? ElevatedButton(
                    onPressed: _pickImage, child: const Text('Pick a photo'))
                : Image.memory(photoBytes!,
                    width: 100, height: 100, fit: BoxFit.cover),
            ElevatedButton(onPressed: savePetInfo, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
