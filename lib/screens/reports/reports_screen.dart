import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  static const String idScreen = "reports";

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  Excel? excel; // Declare the excel variable

  Future<void> writeToExcel(List<List<dynamic>> data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    for (var i = 0; i < data.length; i++) {
      sheet.appendRow(data[i]);
    }

    final Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    final String excelPath =
        path.join(appDocumentsDirectory.path, 'example.xlsx');

    await excel.save(fileName: excelPath);
    print('Excel file saved at $excelPath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            data.sort((a, b) {
              final timestampA = a['Time'] as Timestamp;
              final timestampB = b['Time'] as Timestamp;
              return timestampB.compareTo(timestampA);
            });
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Harness ID')),
                  DataColumn(label: Text('Safe')),
                  DataColumn(label: Text('Time')),
                  // Add more DataColumn widgets for additional columns
                ],
                rows: data.map((doc) {
                  final column1Data = doc['Name'];
                  final column2Data = doc['Harness ID'];
                  final column3Data = doc['Safe'];
                  final column4Data = doc['Time'] as Timestamp;
                  final dateTime = column4Data.toDate();
                  final formattedTime = dateTime.toString();
                  // Add more variables for additional columns' data

                  return DataRow(
                    cells: [
                      DataCell(Center(
                          child: column3Data == 'Yes'
                              ? const Icon(Icons.square, color: Colors.grey)
                              : const Icon(Icons.rectangle,
                                  color: Color.fromARGB(255, 153, 38, 38)))),
                      DataCell(Center(child: Text(column1Data))),
                      DataCell(Center(child: Text(column2Data))),
                      DataCell(Center(child: Text(formattedTime))),
                      // Add more DataCell widgets for additional columns' data
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = [
            ['Name', 'Harness ID', 'Safe', 'Time'],
            // Add your data rows here
          ];
          await writeToExcel(data); // Write data to Excel file
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }
}
