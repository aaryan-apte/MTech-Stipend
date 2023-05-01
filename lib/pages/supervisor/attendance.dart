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
      .collection("students")
      .doc("attendance")
      .collection("${DateTime.now().month}-${DateTime.now().year}");

  String getStudentName(String email) {
    final studentName =
        FirebaseFirestore.instance.collection("students").doc(email);
    final Map<String, dynamic> docData =
        studentName.get() as Map<String, dynamic>;
    String name = docData["name"];
    return name;
  }

  List<Student> students = [
    Student(name: "Alice", hours: 0),
    Student(name: "Bob", hours: 0),
    Student(name: "Charlie", hours: 0),
  ];

  final num _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: studentPath.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData){
            // final docData = ;
            return  const Text("");

          }
          return const SizedBox();
          // return ListView(
          //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //     return StreamBuilder<DocumentSnapshot>(
          //       stream: FirebaseFirestore.instance
          //           .collection('students')
          //           .doc(document.id)
          //           .collection('attendance')
          //           .doc('${DateTime.now().month}-${DateTime.now().year}')
          //           .snapshots(),
          //       builder: (BuildContext context,
          //           AsyncSnapshot<DocumentSnapshot> attendanceSnapshot) {
          //         if (attendanceSnapshot.hasError) {
          //           return Text('Error: ${attendanceSnapshot.error}');
          //         }
          //         if (attendanceSnapshot.connectionState ==
          //             ConnectionState.waiting) {
          //           return const Center(child: Text('Loading...'));
          //         }
          //         var totalAttendance =
          //             attendanceSnapshot.data?.get('totalAttendance') ?? 0;
          //         return ListTile(
          //           title: Text(document.id),
          //           subtitle: Text('Total Attendance: $totalAttendance'),
          //         );
          //       },
          //     );
          //   }).toList(),
          // );
        },
      ),
      // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //   stream: studentPath.snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: Text("No applications till date."),
      //       );
      //     }
      //     if (snapshot.hasError) {
      //       return Column(
      //         children: [
      //           const SizedBox(height: 10.0),
      //           Container(
      //             width: double.infinity,
      //             height: 30.0,
      //             color: Colors.white,
      //             child: Center(
      //               child: Text(snapshot.error.toString()),
      //             ),
      //           ),
      //         ],
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(
      //           backgroundColor: Colors.white,
      //           color: Colors.blue[900],
      //         ),
      //       );
      //     }
      //     if (snapshot.data!.docs.isNotEmpty) {
      //       return ListView.builder(
      //         itemBuilder: (context, int index) {
      //           final documents = snapshot.data?.docs;
      //           String emailStudent = documents![index].id.toString();
      //           return StreamBuilder<DocumentSnapshot>(
      //               stream: studentPath
      //                   .doc(emailStudent)
      //                   .collection("attendance")
      //                   .doc("${DateTime.now().month}-${DateTime.now().year}")
      //                   .snapshots(),
      //               builder:
      //                   (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //                 if (snapshot.data!.exists) {
      //                   Map<String, dynamic> docData =
      //                       snapshot.data!.data() as Map<String, int>;
      //                   if (docData.isNotEmpty) {
      //                     int totalAttendance = docData[0]["totalAttendance"];
      //                     return Text(
      //                         "Student name: ${getStudentName(emailStudent)}\n"
      //                         "Attendance: $totalAttendance");
      //                   }
      //                 }
      //                 // else{
      //                 return SizedBox();
      //                 // }
      //               });
      //         },
      //         itemCount: snapshot.data?.docs.length,
      //       );

      // return ListView.builder(itemBuilder: (context, int index){

      //   String studentName = getStudentName(emailStudent);
      //
      //   Map<String, dynamic> docData =
      //   snapshot.data!.docs[index].data();
      //   return Column(
      //     children: [
      //       Text(studentName),
      //       Text(
      //
      //       )
      //     ],
      //   );
      // },
      // itemCount: snapshot.data!.docs.length,);
      //     } else {
      //       return SizedBox();
      //     }
      //   },
      // ),
      // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //   stream: studentPath.snapshots(),
      // builder: (context, QuerySnapshot<Map<String, dynamic>>){
      //
      //   },
      // ),
      // body: ListView.builder(
      //   itemCount: students.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      //       elevation: 3,
      //       color: Colors.indigo[700],
      //       child: ListTile(
      //         title: Text(students[index].name,
      //             style: const TextStyle(color: Colors.white)),
      //         subtitle: Text("Hours: ${students[index].hours}",
      //             style: const TextStyle(color: Colors.white)),
      //         trailing: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             IconButton(
      //               color: const Color.fromARGB(255, 67, 248, 73),
      //               icon: const Icon(Icons.add),
      //               onPressed: () {
      //                 setState(() {
      //                   students[index].hours += 0.5;
      //                   _count += 0.5;
      //                 });
      //               },
      //             ),
      //             IconButton(
      //               color: const Color.fromARGB(255, 248, 31, 16),
      //               icon: const Icon(Icons.remove),
      //               onPressed: () {
      //                 setState(() {
      //                   if (students[index].hours > 0) {
      //                     students[index].hours -= 0.5;
      //                     _count -= 0.5;
      //                   }
      //                 });
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // BottomAppBar(
      //   child: SizedBox(
      //     height: 50,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Text('Total Count: $_count'),
      //         Text('Week: ${getWeekNumber()}'),
      //       ],
      //     ),
      //   ),
      // ),
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
