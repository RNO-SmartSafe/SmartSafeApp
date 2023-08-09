import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RealTimeScreen extends StatefulWidget {
  const RealTimeScreen({Key? key}) : super(key: key);

  static const String idScreen = "realtime";

  @override
  _RealTimeScreenState createState() => _RealTimeScreenState();
}

class _RealTimeScreenState extends State<RealTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Time State'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('reports').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  data.sort((a, b) {
                    final timestampA = a['Time'] as Timestamp;
                    final timestampB = b['Time'] as Timestamp;
                    return timestampB.compareTo(timestampA);
                  });
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Harness ID')),
                        DataColumn(label: Text('Safe')),
                        // Add more DataColumn widgets for additional columns
                      ],
                      rows: data.map((doc) {
                        final column1Data = doc['Name'];
                        final column2Data = doc['Harness ID'];
                        final column3Data = doc['Safe'];
                        // Add more variables for additional columns' data

                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: column3Data == 'Yes'
                                    ? const Icon(Icons.square,
                                        color: Colors.grey)
                                    : const Icon(Icons.rectangle,
                                        color:
                                            Color.fromARGB(255, 153, 38, 38)))),
                            DataCell(Center(child: Text(column1Data))),
                            DataCell(Center(child: Text(column2Data))),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = [
            ['Name', 'Harness ID', 'Safe'],
            // Add your data rows here
          ];
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }
}
