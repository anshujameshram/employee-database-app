import 'package:e_demo/models/employee.dart';
import 'package:e_demo/screens/add_employee.dart';
import 'package:e_demo/screens/edit_employee.dart';
import 'package:e_demo/services/emp_operations.dart';
import 'package:e_demo/services/jump_to_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employeeList = [];

  void getData() async {
    List<Employee> emp = await EmpOperations.instance.getAllEmployees();

    setState(() {
      employeeList = emp;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await jumpToPage(context, AddEmployee());
          getData();
        },
      ),
      body: employeeList.length == 0 ? showNoData() : displayData(),
    );
  }

  Widget showNoData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('No Employee'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget displayData() {
    return ListView.builder(
      itemCount: employeeList.length,
      itemBuilder: (BuildContext context, int index) {
        Employee emp = employeeList[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(emp.name[0]),
          ),
          title: Text(emp.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${emp.post}  (ID:${emp.id})'),
              Text(
                emp.salary.toString(),
              ),
            ],
          ),
          trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteDatabaseFromEmployee(context, emp);
              }),
          onTap: () async {
            await jumpToPage(
                context,
                EditEmployee(
                  employee: emp,
                ));
            getData();
          },
        );
      },
    );
  }

  void deleteDatabaseFromEmployee(
      BuildContext context, Employee employee) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Employee Demo'),
      content: Text('Do you really want to delete ${employee.name}'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () async {
            await EmpOperations.instance.deleteEmployee(employee);
            getData();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
