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
      appBar: AppBar(
        title: const Text(
          'Pet Info',
          style: TextStyle(
              color: Colors.brown, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: speciesController,
                decoration: const InputDecoration(
                  labelText: 'Species',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedSex,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSex = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Sex',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Unknown']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedAge,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAge = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'Less than 1 year',
                  '1 year',
                  '2 years',
                  '3 years',
                  '4 years',
                  '5 years',
                  '6 years',
                  'Over 7 years'
                ]
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Upload Photo',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.upload_file),
                    onPressed: _pickImage,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (photoBytes != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    photoBytes!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: savePetInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
