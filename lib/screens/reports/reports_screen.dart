import 'dart:math';

import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  static const String idScreen = "reports";
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Reports",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginatedDataTable(
              source: _data,
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('harness Number')),
                DataColumn(label: Text('Safe')),
                // DataColumn(label: Text('time')),
                // DataColumn(label: Text('Date')),
              ],
              columnSpacing: 70,
              horizontalMargin: 60,
              rowsPerPage: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Name $index",
            "harness Number": Random().nextInt(10000),
            "safe": Random().nextInt(2),
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(
        Center(
          child: Text(_data[index]["harness Number"].toString()),
        ),
      ),
      DataCell(
        _data[index]["safe"].toString() == "0"
            ? const Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              )
            : const Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
      ),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
