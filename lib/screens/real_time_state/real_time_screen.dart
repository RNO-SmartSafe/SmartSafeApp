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
                        final safeData = doc['Safe'];
                        final nameData = doc['Name'];
                        final harnessData = doc['Harness ID'];

                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Icon(
                              safeData == 'NO'
                                  ? Icons.error_outline
                                  : Icons.check_circle_outline,
                              color:
                                  safeData == 'NO' ? Colors.red : Colors.green,
                            ))),
                            DataCell(Center(child: Text(nameData))),
                            DataCell(Center(child: Text(harnessData))),
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
