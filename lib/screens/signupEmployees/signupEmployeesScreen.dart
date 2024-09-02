import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/signupEmployee.dart';
import 'package:intl/intl.dart';

import 'components/EmployeeListManager.dart';

class SignupEmployessScreen extends StatefulWidget {
  static const String idScreen = "signupEmployee";

  const SignupEmployessScreen({Key? key}) : super(key: key);

  @override
  _SignupEmployessScreen createState() => _SignupEmployessScreen();
}

class _SignupEmployessScreen extends State<SignupEmployessScreen> {
  final EmployeeListManager _employeeListManager = EmployeeListManager();
  final SignupEmployee _newEmployee =
      SignupEmployee(id: GlobalKey(), name: '', harnessNumber: '');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _harnessNumberController =
      TextEditingController();
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Date')
        .doc(currentDate)
        .collection('Employees')
        .get();

    final List<SignupEmployee> fetchedEmployees = snapshot.docs.map((doc) {
      final data = doc.data();
      return SignupEmployee(
        id: _newEmployee.id,
        name: data['Name'] ?? '',
        harnessNumber: data['Harness ID'] ?? '',
      );
    }).toList();

    setState(() {
      _employeeListManager.setEmployees(fetchedEmployees);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "Signup Employees",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  _form() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (val) =>
                    (val!.isEmpty ? 'This field is mandatory' : null),
                onSaved: (val) => setState(() => _newEmployee.name = val!),
              ),
              TextFormField(
                controller: _harnessNumberController,
                decoration: const InputDecoration(labelText: 'Harness Number'),
                validator: (val) =>
                    (val!.isEmpty ? 'This field is mandatory' : null),
                onSaved: (val) =>
                    setState(() => _newEmployee.harnessNumber = val!),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => _onSubmit(),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print('''
        Full Name : ${_newEmployee.name}
        Harness Number : ${_newEmployee.harnessNumber}
        ''');
      _employeeListManager.addEmployee(SignupEmployee(
          id: _formKey,
          name: _newEmployee.name,
          harnessNumber: _newEmployee.harnessNumber));
      Map<String, String> employeeToSave = {
        'Name': _nameController.text,
        'Harness ID': _harnessNumberController.text,
        'Safe': 'YES',
        'ModifiedTime': 'None'
      };
      FirebaseFirestore.instance
          .collection('Date')
          .doc(currentDate)
          .collection('Employees')
          .add(employeeToSave);

      form.reset();
      _fetchEmployees(); // Refresh the list after adding a new employee
    }
  }

  _list() => Expanded(
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final employee = _employeeListManager.employeesList[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.account_circle,
                        color: Colors.blueGrey,
                        size: 40.0,
                      ),
                      title: Text(
                        employee.name.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(employee.harnessNumber),
                      onTap: () {},
                    ),
                    const Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: _employeeListManager.employeesList.length,
            ),
          ),
        ),
      );
}
