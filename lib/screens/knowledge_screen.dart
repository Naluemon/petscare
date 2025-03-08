// screens/knowledge_screen.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/pet_detail_screen.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> petData = [
      {
        'title': 'Cats',
        'content':
            'Cats are small, carnivorous mammals that are often kept as pets. They are known for their agility, curiosity, and independence.',
        'image': 'assets/images/cat01.jpg',
      },
      {
        'title': 'Dogs',
        'content':
            'Dogs are loyal and intelligent animals that have been domesticated for thousands of years. They are commonly used as companions and working animals.',
        'image': 'assets/images/dog.jpg',
      },
      {
        'title': 'Fish',
        'content':
            'Fish are aquatic creatures that come in various species and sizes. They require proper care, including clean water and a balanced diet.',
        'image': 'assets/images/fish.jpg',
      },
      {
        'title': 'Rabbits',
        'content':
            'Rabbits are small, herbivorous mammals that are popular as pets. They require a balanced diet of hay, vegetables, and pellets.',
        'image': 'assets/images/rabbit.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Knowledge About Pets',
          style: TextStyle(
            fontSize: 22, // ปรับขนาดฟอนต์
            fontWeight: FontWeight.bold,
            color: Colors.brown, // ทำให้ตัวหนา
          ),
        ),
        centerTitle: true, // ทำให้ Title อยู่ตรงกลาง
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: petData.length,
          itemBuilder: (context, index) {
            final pet = petData[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetDetailScreen(
                        title: pet['title']!,
                        content: pet['content']!,
                        image: pet['image']!, // ส่ง image ไปด้วย
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        pet['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              pet['content']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
