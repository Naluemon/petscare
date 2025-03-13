// screens/pet_health_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PetHealthDetailScreen extends StatefulWidget {
  final String petName;
  const PetHealthDetailScreen({super.key, required this.petName});

  @override
  _PetHealthDetailScreenState createState() => _PetHealthDetailScreenState();
}

class _PetHealthDetailScreenState extends State<PetHealthDetailScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _vaccinationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  List<Map<String, String>> healthRecords = [];

  @override
  void initState() {
    super.initState();
    _loadHealthRecords();
  }

  Future<void> _loadHealthRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedRecords =
        prefs.getStringList('health_${widget.petName}') ?? [];

    setState(() {
      healthRecords = storedRecords
          .map((record) => Map<String, String>.from(jsonDecode(record)))
          .toList();
    });
  }

  Future<void> _saveHealthRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> record = {
      'date': DateTime.now().toString().split(' ')[0],
      'weight': _weightController.text,
      'vaccination': _vaccinationController.text,
      'notes': _notesController.text,
    };

    healthRecords.add(record);
    await prefs.setStringList('health_${widget.petName}',
        healthRecords.map((e) => jsonEncode(e)).toList());

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Health record saved!')));
    setState(() {});

    _weightController.clear();
    _vaccinationController.clear();
    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health: ${widget.petName}',
          style: TextStyle(
            color: Colors.brown,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _vaccinationController,
              decoration:
                  const InputDecoration(labelText: 'Vaccination Record'),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Additional Notes'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.all(15)),
              onPressed: _saveHealthRecord,
              child: const Text('Save Record',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: healthRecords.isEmpty
                  ? const Center(child: Text('No health records yet'))
                  : ListView.builder(
                      itemCount: healthRecords.length,
                      itemBuilder: (context, index) {
                        final record = healthRecords[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text("Date: ${record['date']}"),
                            subtitle: Text(
                                "Weight: ${record['weight']} kg\nVaccination: ${record['vaccination']}\nNotes: ${record['notes']}"),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
