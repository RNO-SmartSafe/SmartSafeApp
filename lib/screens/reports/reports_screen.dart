import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  static const String idScreen = "reports";

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>();

  @override
  void initState() {
    super.initState();
    _fetchAlerts(); // Fetch alerts when the screen is initialized
  }

  @override
  void dispose() {
    _streamController
        .close(); // Ensure the StreamController is closed when the screen is disposed
    super.dispose();
  }

  Future<void> _fetchAlerts() async {
    try {
      // Fetch all document IDs from the 'Date' collection
      final dateSnapshots =
          await FirebaseFirestore.instance.collection('Date').get();
      final List<DocumentSnapshot> allAlerts = [];

      for (var dateDoc in dateSnapshots.docs) {
        // For each date document, fetch its 'Alerts' collection
        final alertSnapshots =
            await dateDoc.reference.collection('Alerts').get();
        allAlerts.addAll(alertSnapshots.docs);
      }

      // Add the fetched alerts to the stream
      _streamController.add(allAlerts);
    } catch (e) {
      print('Error fetching alerts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Date & Time')),
                  DataColumn(label: Text('IOT')),
                ],
                rows: data.map((doc) {
                  final name = doc['name'] ?? 'Unknown';
                  final dateTimeString = doc['Date'] ?? '';
                  final iot = doc['IOT'] ?? 'Unknown';

                  // Format the date and time
                  String formattedDateTime = '';
                  try {
                    final dateTime = DateTime.parse(dateTimeString);
                    formattedDateTime =
                        DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                  } catch (e) {
                    formattedDateTime = 'Invalid Date';
                  }

                  return DataRow(
                    cells: [
                      DataCell(Center(child: Text(name))),
                      DataCell(Center(child: Text(formattedDateTime))),
                      DataCell(Center(child: Text(iot))),
                    ],
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
