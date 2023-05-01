import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  incrementAttendance(String docID, num attendance, num totalAttendance) {
    num weekNumber1 = DateTime.now().day / 7 + 1;
    if(weekNumber1 <=1 && weekNumber1 < 2){
      weekNumber1 = 1;
    }
    if(weekNumber1 <=2 && weekNumber1 < 3){
      weekNumber1 = 2;
    }
    if(weekNumber1 <=3 && weekNumber1 < 4){
      weekNumber1 = 3;
    }
    if(weekNumber1 <=4 && weekNumber1 < 5){
      weekNumber1 = 4;
    }
    if(weekNumber1 <=5 && weekNumber1 < 6){
      weekNumber1 = 5;
    }
    attendance = attendance + 1;
    totalAttendance = totalAttendance + 1;
    Map<String, dynamic> map1 = {weekNumber1.toString(): attendance, "totalAttendance": totalAttendance};
    final pathUpdate = FirebaseFirestore.instance
        .collection("supervisor")
        .doc("muk") // TODO: Idhar EMAIL DAALNA HAI
        .collection("attendance")
        .doc("cs")
        .collection("${DateTime.now().month}-${DateTime.now().year}").doc(docID);

    try{
      pathUpdate.update(map1);
    } catch(e){
      return SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  decrementAttendance(String docID, num attendance, num totalAttendance) {
    int weekNumber1 = DateTime.now().day / 7 + 1 as int;
    attendance = attendance - 1;
    totalAttendance = totalAttendance - 1;
    Map<String, dynamic> map1 = {weekNumber1.toString(): attendance, "totalAttendance": totalAttendance};
    final pathUpdate = FirebaseFirestore.instance
        .collection("supervisor")
        .doc("muk") // TODO: Idhar EMAIL DAALNA HAI
        .collection("attendance")
        .doc("cs")
        .collection("${DateTime.now().month}-${DateTime.now().year}").doc(docID);

    try{
      pathUpdate.update(map1);
    } catch(e){
      return SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  TextStyle textStyle1 = const TextStyle(
      fontWeight: FontWeight.w800, fontSize: 21.0, color: Colors.white);

  final studentPath = FirebaseFirestore.instance
      .collection("supervisor")
      .doc("muk") // TODO: Idhar EMAIL DAALNA HAI
      .collection("attendance")
      .doc("cs")
      .collection("${DateTime.now().month}-${DateTime.now().year}");
      .collection("students");

  String getStudentName(String email) {
    final studentName =
        FirebaseFirestore.instance.collection("students").doc(email);
    final Map<String, dynamic> docData =
        studentName.get() as Map<String, dynamic>;
    String name = docData["name"];
    return name;
  }

  // final num _count = 0;

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
                  final documents = snapshot.data?.docs;
                  double weekNumber = (DateTime.now().day / 7 + 1);

                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,

                    itemBuilder: (context, int index) {

                      final docID = documents![index].id;
                      final Map<String, dynamic>? docData =
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>?;

                      if (docData!.isEmpty) {
                        return const Center(
                            child: Text(
                          "Document is Empty",
                          textAlign: TextAlign.center,
                        ));
                      }
                      num totalAttendance = docData["totalAttendance"];
                      String name = docData["name"];
                      if (1 <= weekNumber &&
                          weekNumber < 2 &&
                          docData["1"] != null) {
                        num week1 = docData["1"];
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: textStyle1),
                              const SizedBox(height: 5.0),
                              Text("Total Attendance: $totalAttendance"),
                              Text("1st week: $week1"),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        // surfaceTintColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        incrementAttendance(docID, week1, totalAttendance);
                                      });
                                    },
                                    child: const Icon(Icons.add_rounded),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        decrementAttendance(docID, week1, totalAttendance);
                                      });
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (2 <= weekNumber &&
                          weekNumber < 3 &&
                          docData["2"] != null) {
                        num week1 = docData["1"];
                        num week2 = docData["2"];
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: textStyle1),
                              const SizedBox(height: 5.0),
                              Text("Total Attendance: $totalAttendance"),
                              Text("1st week: $week1"),
                              Text("2nd week: $week2"),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        // surfaceTintColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    onPressed: () {
                                      incrementAttendance(docID, week2, totalAttendance);
                                    },
                                    child: const Icon(Icons.add_rounded),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red),
                                    onPressed: () {
                                      decrementAttendance(docID, week2, totalAttendance);
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (3 <= weekNumber &&
                          weekNumber < 4 &&
                          docData["3"] != null) {
                        num week1 = docData["1"];
                        num week2 = docData["2"];
                        num week3 = docData["3"];
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: textStyle1),
                              const SizedBox(height: 5.0),
                              Text("Total Attendance: $totalAttendance"),
                              Text("1st week: $week1"),
                              Text("2nd week: $week2"),
                              Text("3rd week: $week3"),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        // surfaceTintColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    onPressed: () {
                                      incrementAttendance(docID, week3, totalAttendance);
                                    },
                                    child: const Icon(Icons.add_rounded),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red),
                                    onPressed: () {
                                      decrementAttendance(docID, week3, totalAttendance);
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (4 <= weekNumber &&
                          weekNumber < 5 &&
                          docData["4"] != null) {
                        num week1 = docData["1"];
                        num week2 = docData["2"];
                        num week3 = docData["3"];
                        num week4 = docData["4"];
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: textStyle1),
                              const SizedBox(height: 5.0),
                              Text("Total Attendance: $totalAttendance"),
                              Text("1st week: $week1"),
                              Text("2nd week: $week2"),
                              Text("3rd week: $week3"),
                              Text("4th week: $week4"),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        // surfaceTintColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    onPressed: () {
                                      incrementAttendance(docID, week4, totalAttendance);
                                    },
                                    child: const Icon(Icons.add_rounded),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red),
                                    onPressed: () {
                                      decrementAttendance(docID, week4, totalAttendance);
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (5 <= weekNumber &&
                          weekNumber < 6 &&
                          docData["5"] != null) {
                        num week1 = docData["1"];
                        num week2 = docData["2"];
                        num week3 = docData["3"];
                        num week4 = docData["4"];
                        num week5 = docData["5"];
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: textStyle1),
                              const SizedBox(height: 5.0),
                              Text("Total Attendance: $totalAttendance"),
                              Text("1st week: $week1"),
                              Text("2nd week: $week2"),
                              Text("3rd week: $week3"),
                              Text("4th week: $week4"),
                              Text("5th week: $week5"),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        // surfaceTintColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    onPressed: () {
                                      incrementAttendance(docID, week5, totalAttendance);
                                    },
                                    child: const Icon(Icons.add_rounded),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.red),
                                    onPressed: () {
                                      decrementAttendance(docID, week5, totalAttendance);
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                }

                // if(snapshot.hasData){
                //   // final docData = ;
                //   return  const Text("");
                //
                // }
                // return const SizedBox();

                // return ListView.builder(
                //   itemBuilder: (BuildContext context, int index) {
                //
                //   },
                //   itemCount: ,
                // );
                // children: snapshot.data!.docs.map((DocumentSnapshot document) {
                //   return StreamBuilder<DocumentSnapshot>(
                //     stream: FirebaseFirestore.instance
                //         .collection('students')
                //         .doc(document.id)
                //         .collection('attendance')
                //         .doc('${DateTime.now().month}-${DateTime.now().year}')
                //         .snapshots(),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<DocumentSnapshot> attendanceSnapshot) {
                //       if (attendanceSnapshot.hasError) {
                //         return Text('Error: ${attendanceSnapshot.error}');
                //       }
                //       if (attendanceSnapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return const Center(child: Text('Loading...'));
                //       }
                //       var totalAttendance =
                //           attendanceSnapshot.data?.get('totalAttendance') ?? 0;
                //       return ListTile(
                //         title: Text(document.id),
                //         subtitle: Text('Total Attendance: $totalAttendance'),
                //       );
                //     },
                //   );
                // }).toList(),`
              }
              return const SizedBox();
            }));

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
    
      appBar: AppBar(
        title: const Text('Attendance'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .doc(document.id)
                    .collection('attendance')
                    .doc('${DateTime.now().month}-${DateTime.now().year}')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> attendanceSnapshot) {
                  if (attendanceSnapshot.hasError) {
                    return Text('Error: ${attendanceSnapshot.error}');
                  }
                  if (attendanceSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Text('Loading...'));
                  }
                  var totalAttendance = attendanceSnapshot.data?.get('totalAttendance') ?? 0;
                  return ListTile(
                    title: Text(document.id),
                    subtitle: Text('Total Attendance: $totalAttendance'),
                  );
                },
              );
            }).toList(),
          );
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
