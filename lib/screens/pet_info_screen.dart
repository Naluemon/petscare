// screens/pet_info_screen.dart
import 'package:flutter/material.dart';

class PetInfoScreen extends StatelessWidget {
  const PetInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Pet Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // สำหรับกรอกตัวเลข
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Pet Breed',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ลอจิกการบันทึกข้อมูลสัตว์เลี้ยง
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pet information saved!')),
                );
              },
              child: const Text('Save Pet Info'),
            ),
          ],
        ),
      ),
    );
  }
}
