import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w700);
  String? email = FirebaseAuth.instance.currentUser?.email;

  final pathStudent = FirebaseFirestore.instance
      .collection("students")
      .doc("ajapte")
      .collection("status");
  // .collection("status");

  final Map<String, String> monthMap = {
    "1": "January",
    "2": "February",
    "11": "November",
    "3": "March",
    "4": "April",
    "5": "May",
    "6": "June",
    "7": "July",
    "8": "August",
    "9": "September",
    "10": "October",
    "12": "December",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Status Page"),
        ),

        // IMPORTANT CODE!!!!!!!!!

        // body: StreamBuilder<DocumentSnapshot>(
        //     stream: pathStudent.snapshots(),
        //     builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //       if (snapshot.hasError) {
        //         return Container(
        //           color: Colors.white,
        //           child: Center(
        //             child: Text(snapshot.error.toString()),
        //           ),
        //         );
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             backgroundColor: Colors.white,
        //             color: Colors.blue[900],
        //           ),
        //         );
        //       }
        //       Map<String, dynamic> docData =
        //           snapshot.data!.data() as Map<String, dynamic>;
        //       if (docData.isNotEmpty) {
        //         num approved = docData["approved"];
        //         // int id = docData["id"];
        //         // String name = docData["name"];
        //         return Column(
        //           children: [
        //             Text("approved: $approved"),
        //             // Text("Name: $name")
        //           ],
        //         );
        //       }
        //       return const SizedBox();
        //     }),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: pathStudent.snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No applications till date."),
              );
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    height: 30.0,
                    color: Colors.white,
                    child: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.blue[900],
                ),
              );
            }

            if (snapshot.data!.docs.isNotEmpty) {
              // print("There is data!");
              return ListView.separated(
                itemBuilder: (context, int index) {
                  final documents = snapshot.data?.docs;
                  String docID = documents![index].id.toString();
                  String? month = monthMap[docID[0]];

                  Map<String, dynamic> docData =
                      snapshot.data!.docs[index].data();
                  num approved = docData["approved"];

                  return Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height/9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue
                    ),
                    child: Column(
                      children: [
                        Text("Month: $month", style: textStyle,),
                        Text(approved.toString(), style: textStyle,),
                        // Text(approved.toString(), style: textStyle,),
                      ],
                    ),
                  );
                },
                separatorBuilder: (___, ____) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length,
              );
            }
            return const Center(child: Text("no data!"));
          },
        ),
      ),
    );
  }
}
