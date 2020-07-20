import 'package:e_demo/models/employee.dart';
import 'package:e_demo/services/emp_operations.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          SizedBox(height: 8),
          TextField(
            controller: postController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Post'),
          ),
          SizedBox(height: 8),
          TextField(
            controller: salaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Salary'),
          ),
          SizedBox(height: 8),
          RaisedButton(
            child: Text('add employee'),
            onPressed: () async {
              addToDatabase(context);
            },
          )
        ],
      ),
    );
  }

  void addToDatabase(BuildContext context) async {
    String n = nameController.text;
    String p = postController.text;
    int s = int.parse(salaryController.text);

    Employee e = Employee(name: n, post: p, salary: s);

    await EmpOperations.instance.addEmployee(e);

    Navigator.pop(context);
  }
}
