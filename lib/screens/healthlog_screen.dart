// screens/healthlog_screen.dart
import 'package:flutter/material.dart';
import 'pet_health_detail_screen.dart';

class HealthlogScreen extends StatelessWidget {
  const HealthlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pets = [
      {'name': 'Milo', 'type': 'Dog', 'image': 'assets/images/dog02.jpg'},
      {'name': 'Whiskers', 'type': 'Cat', 'image': 'assets/images/cat02.jpg'},
      {'name': 'Nemo', 'type': 'Fish', 'image': 'assets/images/fish.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Health '),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(pet['image']!),
                radius: 30,
              ),
              title: Text(
                pet['name']!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(pet['type']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PetHealthDetailScreen(petName: pet['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
