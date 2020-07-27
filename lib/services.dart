import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employee.dart';

class Services {
  static const ROOT = "https://tryoneandone.000webhostapp.com/index.php";
  static const CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  //method to create table employee
  static Future<String> createTable() async {
    try {
      //add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = CREATE_TABLE_ACTION;
      print('map action $map');
      final response = await http.post(ROOT, body: map);
      print('create table response: ${response.body}');
      return response.body;
    } catch (e) {
      return 'error1';
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print(response.statusCode);
      print('getting table response: ${response.body}');
      if (response.statusCode == 200) {
        List<Employee> list = parseResponse(response.body);
        print('list $list');
        return list;
      } else {
        return List<Employee>();
      }
    } catch (e) {
      print(e);
      return List<Employee>();
    }
  }

  static List<Employee> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  //method to add employee to database
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('add employee response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }

  //method to update Employee
  static Future<String> updateEmployee(
      String empID, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empID;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print('update employee response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }

  //method to delete employee
  static Future<String> deleteEmployee(String empID) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empID;
      final response = await http.post(ROOT, body: map);
      print('update employee response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }
}
