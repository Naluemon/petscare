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
        'content': 'Behavior: Cats are independent animals and often do things on their own terms. '
            'They enjoy personal space and prefer high places like shelves or counters.\n\n'
            'Care: Regular cleaning of the litter box is important. Grooming helps reduce shedding and prevent hairballs.\n\n'
            'Diet: Cats are obligate carnivores, their diet should include high-protein foods like chicken or fish.\n\n'
            'Training: Cats can be trained to follow commands, like using the litter box or performing simple tricks.',
        'image': 'assets/images/cat01.jpg',
      },
      {
        'title': 'Dogs',
        'content': 'Behavior: Dogs are social and loyal animals that enjoy interacting with their owners. '
            'They enjoy walks, playtime, and seek attention.\n\n'
            'Care: Regular grooming and vet check-ups are necessary for maintaining their health.\n\n'
            'Diet: Dogs are omnivores needing a balanced diet of meat and vegetables.\n\n'
            'Training: Dogs are highly trainable and can follow various commands.',
        'image': 'assets/images/dog.jpg',
      },
      {
        'title': 'Rabbits',
        'content': 'Behavior: Rabbits are calm and social animals that love digging and nibbling on things.\n\n'
            'Care: They need space for exercise and a quiet area for resting.\n\n'
            'Diet: Rabbits are herbivores and need hay, vegetables, and fresh greens in their diet.\n\n'
            'Training: Rabbits can be trained to use a litter box and perform tricks.',
        'image': 'assets/images/rabbit.jpg',
      },
      {
        'title': 'Fish',
        'content': 'Behavior: Fish vary in species, some swim alone while others live in schools. '
            'They do not require much attention but need a stable environment.\n\n'
            'Care: Clean water is crucial for fish health. Regular water changes and monitoring water quality are important.\n\n'
            'Diet: Fish need different types of food based on their species.\n\n'
            'Training: Fish can be conditioned to eat from your hand or respond to movements.',
        'image': 'assets/images/fish.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Knowledge About Pets',
          style: TextStyle(
            fontSize: 24, // ปรับขนาดฟอนต์
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Use maxLines and ellipsis for overflow handling
                            Text(
                              pet['content']!,
                              maxLines: 2, // Limit the text to 2 lines
                              overflow: TextOverflow
                                  .ellipsis, // Show ellipsis if it's too long
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
