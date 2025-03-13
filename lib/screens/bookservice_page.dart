// screens/bookservice_page.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/%E0%B8%B4booking_history_screen.dart'; //ประวัติการจอง
import 'booking_screen.dart'; // หน้าจอง

class BookservicePage extends StatelessWidget {
  const BookservicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Bath & Grooming',
        'image': 'assets/images/grooming.jpg',
        'description': 'Bathing and grooming services for pets of all sizes.',
      },
      {
        'title': 'Pet Health Check',
        'image': 'assets/images/health_check.jpg',
        'description':
            'Consultation and health check-ups by professional veterinarians.',
      },
      {
        'title': 'Pet Hotel',
        'image': 'assets/images/pet_hotel.jpg',
        'description': 'Pet boarding services with close care and attention.',
      },
      {
        'title': 'Dog Training',
        'image': 'assets/images/training.jpg',
        'description':
            'Professional dog training courses with expert trainers.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Service',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: const Icon(Icons.history), // ไอคอนประวัติการจอง
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
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
                    builder: (context) =>
                        BookingScreen(serviceTitle: service['title']!),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      service['image']!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          service['description']!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
