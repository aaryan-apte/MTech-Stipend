import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class Student {
  String name;
  double hours;

  Student({required this.name, required this.hours});
}

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final studentPath = FirebaseFirestore.instance
      .collection("supervisor")
      .doc("muk") // TODO: Idhar EMAIL DAALNA HAI
      .collection("attendance")
      .doc("cs")
      .collection("${DateTime.now().month}-${DateTime.now().year}");

  String getStudentName(String email) {
    final studentName =
        FirebaseFirestore.instance.collection("students").doc(email);
    final Map<String, dynamic> docData =
        studentName.get() as Map<String, dynamic>;
    String name = docData["name"];
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: studentPath.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            print("Total Documents: ${snapshot.data!.docs.length}");
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic>? docData =
                      snapshot.data?.docs[index].data()
                          as Map<String, dynamic>?;
                  if (docData!.isEmpty) {
                    return const Text(
                      "Document is Empty",
                      textAlign: TextAlign.center,
                    );
                  }

                  String name = docData["name"];
                  num totalAttendance = docData["totalAttendance"];
                  num week1 = docData["1"];
                  num week2 = docData["2"];
                  num week3 = docData["3"];
                  num week4 = docData["4"];
                  String email = docData["email"];
                  print(email);

                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                        title:Text(name),
                        subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0), // add some spacing between the widgets
                          Text("Total Attendance: $totalAttendance"),
                          Text("Week 1: $week1"),
                          Text("Week 2: $week2"),
                          Text("Week 3: $week3"),
                          Text("Week 4: $week4"),
                        ],
                      ),
                      trailing:Row(
                        mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Colors.green,
                              focusColor: Colors.lightGreen,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                print(getWeekNumber());
                                studentPath
                                    .doc(docData["email"])
                                    .update({"${getWeekNumber()}": docData["${getWeekNumber()}"] + 1,"totalAttendance": totalAttendance+1});
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                studentPath.doc(docData["email"]).update({
                                  "${getWeekNumber()}":
                                      docData["${getWeekNumber()}"] - 1,
                                      "totalAttendance": totalAttendance-1
                                });
                              },
                            ),
                          ],
                        ),
                    ),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  int getWeekNumber() {
    var now = DateTime.now();
    var startOfMonth = DateTime(now.year, now.month, 1);
    var currentWeekday = now.weekday;
    var firstMonday = startOfMonth
        .add(Duration(days: currentWeekday > 1 ? 8 - currentWeekday : 1));
    var currentMonday = now.subtract(Duration(days: now.weekday - 1));
    var weekNumber = currentMonday.difference(firstMonday).inDays ~/ 7 + 1;
    return weekNumber;
  }
}
