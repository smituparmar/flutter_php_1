import 'package:employee_database_try/services.dart';
import 'package:flutter/material.dart';
import 'employee.dart';

class DataTableDemo extends StatefulWidget {
  final String title = "flutter data table";
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstNameController, _lastNameController;
  Employee _SelectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    print("getting employees");
    _getEmployees();
  }

  _createTable() {
    _showProgress('creating table');
    print('kuch bhi');
    print(Services.createTable());
    Services.createTable().then((result) {
      print(result);
      if (result == 'success') {
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
    print("end");
  }

  _addEmployee() {
    print(_firstNameController.text);
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print("empty fields");
      return;
    }
    _showProgress("adding employee");
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then(
      (result) {
        if (result == "success") {
          _getEmployees();
          _clearValue();
        }
      },
    );
  }

  _getEmployees() {
    _showProgress("loading");
    Services.getEmployees().then(
      (employee) {
        setState(() {
          print(employee);
          _employees = employee;
        });
        _showProgress(widget.title);
        print('length ${employee.length}');
      },
    );
  }

  _updateTable(Employee employee) {
    _showProgress("updating");
    Services.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if (result == 'success') {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _clearValue();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('delete Employee');
    Services.deleteEmployee(employee.id).then((result) {
      if (result == 'success') {
        _getEmployees();
      }
    });
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  //method to create text fields

  _clearValue() {
    _firstNameController.clear();
    _lastNameController.clear();
  }

  //data table
  SingleChildScrollView _dataBody() {
    _employees.forEach((element) {
      print('elements $element');
    });
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('First Name'),
            ),
            DataColumn(
              label: Text('Last Name'),
            ),
          ],
          rows: _employees
              .map((e) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          e.id.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          e.first_name,
                        ),
                      ),
                      DataCell(
                        Text(
                          e.last_name,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(hintText: 'first name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(hintText: 'last name'),
              ),
            ),
            //update and cancel button
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('Update'),
                        //  onPressed: _updateTable(),
                      ),
                      OutlineButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
