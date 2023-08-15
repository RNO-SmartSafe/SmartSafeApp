import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealTimeScreen extends StatefulWidget {
  const RealTimeScreen({Key? key}) : super(key: key);

  static const String idScreen = "realtime";

  @override
  _RealTimeScreenState createState() => _RealTimeScreenState();
}

class _RealTimeScreenState extends State<RealTimeScreen> {
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
              stream: FirebaseFirestore.instance
                  .collection('Date')
                  .doc(currentDate)
                  .collection('Employees')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Safe')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Harness ID')),
                      ],
                      rows: data.map((doc) {
                        final column3Data = doc['Safe'];
                        final column1Data = doc['Name'];
                        final column2Data = doc['Harness ID'];

                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Icon(
                              column3Data == 'NO'
                                  ? Icons.error_outline
                                  : Icons.check_circle_outline,
                              color: column3Data == 'NO'
                                  ? Colors.red
                                  : Colors.green,
                            ))),
                            DataCell(Center(child: Text(column1Data))),
                            DataCell(Center(child: Text(column2Data))),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
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
    );
  }
}
