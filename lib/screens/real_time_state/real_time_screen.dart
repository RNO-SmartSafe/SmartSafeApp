import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeScreen extends StatefulWidget {
  const RealTimeScreen({Key? key}) : super(key: key);

  static const String idScreen = "realtime";

  @override
  _RealTimeScreenState createState() => _RealTimeScreenState();
}

class _RealTimeScreenState extends State<RealTimeScreen> {
  Color _iconColor = Colors.red; // Initial color
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('realtime');

  // String _safeValue = " ";

  // @override
  // void initState() {
  //   super.initState();

  //   _collection.onValue.listen((event) {
  //     setState(() {
  //       _safeValue = event.snapshot.value.toString();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool is_safe = false;
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
                  FirebaseFirestore.instance.collection('realtime').snapshots(),
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
                        // Add more DataColumn widgets for additional columns
                      ],
                      rows: data.map((doc) {
                        final column3Data = doc['Safe'];
                        final column1Data = doc['Name'];
                        final column2Data = doc['Harness ID'];
                        // Add more variables for additional columns' data

                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Icon(
                              column3Data == 'YES'
                                  ? Icons.check_circle_outline
                                  : Icons.error_outline,
                              color: column3Data == 'YES'
                                  ? Colors.green
                                  : Colors.red,
                            ))),
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
    );
  }
}
