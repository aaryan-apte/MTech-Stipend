import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class SupervisorRecords extends StatefulWidget {
  const SupervisorRecords({Key? key}) : super(key: key);

  @override
  State<SupervisorRecords> createState() => _SupervisorRecordsState();
}

class _SupervisorRecordsState extends State<SupervisorRecords> {
  TextStyle textStyle1 = const TextStyle(color: Colors.white, fontSize: 17.0);
  final TextEditingController _textMonth = TextEditingController();
  var test1;

  // String yearPicked = DateTime.now().year.toString();
  String monthYearPicked = "${DateTime.now().month}-${DateTime.now().year}";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Records Page",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.black54,
              height: 0.2,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.brown),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white54,
          ),
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.c,
            children: [
              const SizedBox(height: 20),
              TextField(
                  //onChanged: (value) =>
                  controller: _textMonth,
                  decoration: const InputDecoration(
                    hintText: 'Select Month',
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    var month = DateTime.now();
                    month = showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2100),
                    ) as DateTime;
                    setState(
                      () {
                        monthYearPicked = "${month.month}-${month.year}";
                        _textMonth.text = "${month.month}-${month.year}";

                        print("${month.year}");
                      },
                    );
                    // style:
                    //   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  }),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("supervisor")
                          .doc("muk") // TODO: Idhar EMAIL DAALNA HAI
                          .collection("attendance")
                          .doc("cs")
                          .collection(monthYearPicked)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        // print(test1);
                        if (snapshot.hasData && snapshot.data != null) {
                          print(
                              "Total Documents: ${snapshot.data!.docs.length}");
                          if (snapshot.data!.docs.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, int index) {
                                Map<String, dynamic> docData =
                                    snapshot.data!.docs[index].data();

                                if (docData.isEmpty) {
                                  return const Text(
                                    "Document is Empty",
                                    textAlign: TextAlign.center,
                                  );
                                }

                                String studentName = docData["name"];
                                num id = docData["id"];
                                num approved = docData["approved"];
                                num totalAttendance =
                                    docData["totalAttendance"];
                                num w1 = docData["1"];
                                num w2 = docData["2"];
                                num w3 = docData["3"];
                                num w4 = docData["4"];
                                if (docData["5"] != null) {
                                  num w5 = docData["5"];
                                }
                                final String approvalStatus;
                                if (approved == 2) {
                                  approvalStatus = "Approved";
                                } else if (approved == 0) {
                                  approvalStatus = "Pending";
                                } else if (approved == 1) {
                                  approvalStatus = "Approved By Supervisor";
                                } else {
                                  approvalStatus = "Denied";
                                }

                                return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    margin: const EdgeInsets.all(10.0),
                                    elevation: 3,
                                    color: Colors.blue[900],
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      childrenPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      title: Text(studentName),
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Column(children: [
                                              Text(
                                                id.toString(),
                                                style: textStyle1,
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Total Attendance: ${totalAttendance.toString()}",
                                                style: textStyle1,
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Week 1: ${w1.toString()}",
                                                style: textStyle1,
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Week 2: ${w2.toString()}",
                                                style: textStyle1,
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Week 3: ${w3.toString()}",
                                                style: textStyle1,
                                              ),
                                              const SizedBox(height: 10.0),
                                              Text(
                                                "Week 4: ${w4.toString()}",
                                                style: textStyle1,
                                              ),
                                            ])),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          "Approval Status: $approvalStatus",
                                          style: textStyle1,
                                        ),
                                      ],
                                    ));
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'There are no records for $monthYearPicked',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.0),
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: Text("Getting Error"),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
