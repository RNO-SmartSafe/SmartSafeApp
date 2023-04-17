import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/signupEmployee.dart';
import 'package:intl/intl.dart';

class SignupEmployessScreen extends StatefulWidget {
  static const String idScreen = "signupEmployee";

  const SignupEmployessScreen({Key? key}) : super(key: key);

  @override
  _SignupEmployessScreen createState() => _SignupEmployessScreen();
}

class _SignupEmployessScreen extends State<SignupEmployessScreen> {
  // final FirebaseFirestore database = FirebaseFirestore.instance;
  // FirestoreReference ref = database.getReference("server/saving-data/fireblog/posts");
  final SignupEmployee _newEmployee =
      SignupEmployee(id: GlobalKey(), name: '', harnessNumber: '');
  final List<SignupEmployee> _employeesList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _harnessNumberController =
      TextEditingController();
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  child: const Text('Submit'),
                ),
              ),
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
      _employeesList.add(SignupEmployee(
          id: _formKey,
          name: _newEmployee.name,
          harnessNumber: _newEmployee.harnessNumber));
      Map<String, String> employeeToSave = {
        'name': _nameController.text,
        'harness number': _harnessNumberController.text
      };
      FirebaseFirestore.instance
          .collection('company')
          .doc('general')
          .collection('date')
          .doc(currentDate)
          .collection('employees')
          .add(employeeToSave);

      form.reset();
    }
  }

  _list() => Expanded(
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.account_circle,
                        color: Colors.blueGrey,
                        size: 40.0,
                      ),
                      title: Text(
                        _employeesList[index].name.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_employeesList[index].harnessNumber),
                      onTap: () {},
                    ),
                    const Divider(
                      height: 5.0,
                    ),
                  ],
                );
              },
              itemCount: _employeesList.length,
            ),
          ),
        ),
      );
}
