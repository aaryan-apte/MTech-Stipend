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
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),

                decoration:
                BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10.0)),
                child: ExpansionTile(
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  childrenPadding: const EdgeInsets.all(10.0),
                  title: Text(students[index].name,
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text("Hours: ${students[index].hours}",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.blue[100],
                  collapsedBackgroundColor: Colors.blue[100],
                  collapsedTextColor: Colors.white,
                  textColor: Colors.white,
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

                  children:  [

                    Text('Month: ${getMonthName(DateTime.now())}', textAlign: TextAlign.left),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Week ${getWeekNumber()} : '),
                            ),

                            //TO DO
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Week ${getWeekNumber()+1} : '),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Week ${getWeekNumber()+2} : '),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Week ${getWeekNumber()+3} : '),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
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

  String getMonthName(DateTime date) {
    return new DateFormat.MMMM().format(date);
  }

  int getDaysinaMonth(DateTime date){
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  int getNoofWeeksinaMonth(int days){
    var noofdays = getDaysinaMonth(DateTime.now());
    var weeks = noofdays~/7;
    return weeks;
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