import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Student {
  String name;
  double hours;

  Student({required this.name, required this.hours});
}

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Student> students = [
    Student(name: "Alice", hours: 0),
    Student(name: "Bob", hours: 0),
    Student(name: "Charlie", hours: 0),
  ];

  double _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 15,
            color: Color.fromARGB(255, 0, 0, 0),
            child: ListTile(
              title: Text(students[index].name,
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("Hours: ${students[index].hours}",
                  style: TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: Color.fromARGB(255, 67, 248, 73),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        students[index].hours += 0.5;
                        _count += 0.5;
                      });
                    },
                  ),
                  IconButton(
                    color: Color.fromARGB(255, 248, 31, 16),
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (students[index].hours > 0) {
                          students[index].hours -= 0.5;
                          _count -= 0.5;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total Count: $_count'),
              Text('Week: ${getWeekNumber()}'),
            ],
          ),
        ),
      ),
    );
  }

  int getWeekNumber() {
    var now = DateTime.now();
    var startOfYear = DateTime(now.year, 1, 1);
    var firstMonday =
        startOfYear.subtract(Duration(days: startOfYear.weekday - 1));
    var currentMonday = now.subtract(Duration(days: now.weekday - 1));
    var weekNumber = currentMonday.difference(firstMonday).inDays ~/ 7 + 1;
    return weekNumber;
  }
}
