// screens/booking_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookingScreen extends StatefulWidget {
  final String serviceTitle;

  const BookingScreen({Key? key, required this.serviceTitle}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _saveBooking() async {
    String name = _nameController.text;
    String date = _dateController.text;
    String time = _timeController.text;

    if (name.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields!')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookings = prefs.getStringList('bookings') ?? [];

    Map<String, String> bookingData = {
      'service': widget.serviceTitle,
      'name': name,
      'date': date,
      'time': time,
    };

    bookings.add(jsonEncode(bookingData));
    await prefs.setStringList('bookings', bookings);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking Confirmed!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.serviceTitle}'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name')),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Select Date'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null)
                  setState(() => _dateController.text =
                      pickedDate.toString().split(' ')[0]);
              },
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Select Time'),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (pickedTime != null)
                  setState(
                      () => _timeController.text = pickedTime.format(context));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.all(15)),
              onPressed: _saveBooking,
              child:
                  const Text('Confirm Booking', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
