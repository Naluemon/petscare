// screens/ิbooking_history_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<Map<String, String>> bookingHistory = [];

  @override
  void initState() {
    super.initState();
    _loadBookingHistory();
  }

  Future<void> _loadBookingHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedBookings = prefs.getStringList('bookings') ?? [];

    setState(() {
      bookingHistory = storedBookings
          .map((booking) => Map<String, String>.from(jsonDecode(booking)))
          .toList();
    });
  }

  Future<void> _clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('bookings');
    setState(() {
      bookingHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: bookingHistory.isEmpty
          ? const Center(child: Text('No booking history found'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      booking['service']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Name: ${booking['name']}\nDate: ${booking['date']}\nTime: ${booking['time']}"),
                    leading: const Icon(Icons.event_note, color: Colors.blue),
                  ),
                );
              },
            ),
    );
  }
}
