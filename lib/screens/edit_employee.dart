import 'package:e_demo/models/employee.dart';
import 'package:e_demo/services/emp_operations.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatelessWidget {
  final Employee employee;

  EditEmployee({this.employee});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = employee.name;
    postController.text = employee.post;
    salaryController.text = employee.salary.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Employee'),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: postController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Post',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Salary',
              ),
            ),
            SizedBox(height: 8),
            RaisedButton(
              child: Text('edit employee'),
              onPressed: () async {
                editTodatabase(context);
              },
            )
          ],
        ));
  }

  void editTodatabase(BuildContext context) async {
    String n = nameController.text;
    String p = postController.text;
    int s = int.parse(salaryController.text);

    Employee e = Employee(id: employee.id, name: n, post: p, salary: s);

    await EmpOperations.instance.editEmployee(e);

    Navigator.pop(context);
  }
}
