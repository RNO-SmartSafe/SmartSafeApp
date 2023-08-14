import '../../../models/signupEmployee.dart';

//Singelton Class
class EmployeeListManager {
  static final EmployeeListManager _instance = EmployeeListManager._internal();

  factory EmployeeListManager() {
    return _instance;
  }

  EmployeeListManager._internal();

  final List<SignupEmployee> _employeesList = [];

  List<SignupEmployee> get employeesList => _employeesList;

  void addEmployee(SignupEmployee employee) {
    _employeesList.add(employee);
  }
}
