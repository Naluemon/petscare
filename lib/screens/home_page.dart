// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/pet_info_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pets = [];

  @override
  void initState() {
    super.initState();
    pets = [
      {'name': 'Milo', 'type': 'Dog', 'image': 'assets/images/dog02.jpg'},
      {'name': 'Whiskers', 'type': 'Cat', 'image': 'assets/images/cat02.jpg'},
      {'name': 'Nemo', 'type': 'Fish', 'image': 'assets/images/fish.jpg'},
    ];
  }

  void _confirmDeletePet(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Pet"),
        content: const Text("Are you sure you want to delete this pet?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                pets.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildPetGridPage() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          child: const Text(
            'Pets',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: pets.isEmpty
                ? const Center(
                    child: Text(
                      "ยังไม่มีสัตว์เลี้ยง",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () => _confirmDeletePet(index),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: pets[index]['photoBytes'] != null
                                      ? DecorationImage(
                                          image: MemoryImage(
                                              pets[index]['photoBytes']),
                                          fit: BoxFit
                                              .cover, // ปรับให้ภาพเต็มกรอบ
                                        )
                                      : DecorationImage(
                                          image:
                                              AssetImage(pets[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              pets[index]['name'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5A2B),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              final newPet = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PetInfoScreen()),
              );

              if (newPet != null && mounted) {
                setState(() {
                  // เพิ่มข้อมูลสัตว์เลี้ยงที่ได้จาก PetInfoScreen
                  pets.add(newPet);
                });
              }
            },
            child: const Text('Add more pet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _buildPetGridPage(),
      ),
    );
  }
}
