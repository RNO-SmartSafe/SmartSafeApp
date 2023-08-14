import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  static const String idScreen = "reports";

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Alerts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    //   DataColumn(label: Text('Harness ID')),
                    // DataColumn(label: Text('Time')),
                    DataColumn(label: Text('Date & Time')),
                    DataColumn(label: Text('IOT')),
                    // DataColumn(label: Text('from')),
                    // DataColumn(label: Text('message type')),
                    // DataColumn(label: Text('messege number')),
                  ],
                  rows: data.map((doc) {
                    final column5Data = doc['name'];
                    // final column2Data = doc['Harness ID'];
                    // final column3Data = doc['Safe'];
                    // final column4Data = doc['Time'] as Timestamp;
                    // final dateTime = column4Data.toDate();
                    // final formattedTime = dateTime.toString();

                    final column1Data = doc['Date'];
                    final column2Data = doc['IOT'];
                    // final column3Data = doc['from'];
                    // final column4Data = doc['message type'];

                    return DataRow(
                      cells: [
                        // DataCell(Center(child: Text(column1Data))),
                        // DataCell(Center(child: Text(column2Data))),
                        // DataCell(Center(child: Text(formattedTime))),

                        DataCell(Center(child: Text(column5Data))),
                        DataCell(Center(child: Text(column1Data))),
                        DataCell(Center(child: Text(column2Data))),
                        // DataCell(Center(child: Text(column3Data))),
                        // DataCell(Center(child: Text(column4Data))),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final data = [
      //       // ['Name', 'Harness ID', 'Safe', 'Time'],
      //       ['Safe', 'Date', 'IOT', 'from', 'message type']
      //     ];
      //   },
      //   child: const Icon(Icons.file_download),
      // ),
    );
  }
}
