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
  }

  _createTable() {}

  _addEmployee() {}

  _getEmployees() {}

  _updateTable() {}

  _deleteEmployee() {}

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  //method to create text fields

  _clearValue() {
    _firstNameController.clear();
    _lastNameController.clear();
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
            onPressed: _createTable(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _getEmployees(),
          )
        ],
      ),
      body: Container(
        child: Column(
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
                        onPressed: _updateTable(),
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
          ],
        ),
      ),
    );
  }
}
