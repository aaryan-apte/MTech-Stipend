// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/loginRegister/login.dart';
import 'package:mtech_stipend/pages/hod/hod_records.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mtech_stipend/pages/supervisor/supervisor_records.dart';

class SupervisorPage extends StatefulWidget {
  const SupervisorPage({Key? key}) : super(key: key);

  @override
  State<SupervisorPage> createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  TextEditingController reasonController = TextEditingController();

  void sendData() {
    final pathSupervisor = FirebaseFirestore.instance
        .collection("branch")
        .doc(getBranch())
        .collection("supervisor")
        .doc(DateTime.now().month.toString())
        .collection('applications');
  }

  void alertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: reasonController,
              maxLines: 2,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Reason for denial...",
                hintStyle: TextStyle(
                  color: Colors.black45,
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 30.0),
            const SizedBox(height: 10.0),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                child: Text(
                  "Deny",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // final String? email = FirebaseAuth.instance.currentUser?.email;
  final String email = "ajapte_b21@ce.vjti.ac.in";
  String getBranch() {
    // final String? email = FirebaseAuth.instance.currentUser?.email;

    int i = 0;
    while (email[i] != '@') {
      i = i + 1;
    }
    i = i + 1;
    if (email[i] + email[i + 1] == "ce") {
      return "ce";
    } else if (email[i] + email[i + 1] == "it") {
      return "it";
    } else if (email[i] + email[i + 1] == "ee") {
      return "ee";
    } else if (email[i] + email[i + 1] == "me") {
      return "me";
    } else if (email[i] + email[i + 1] == "pe") {
      return "pe";
    } else if (email[i] + email[i + 1] == "tx") {
      return "tx";
    } else if (email[i] + email[i + 1] == "el") {
      return "el";
    } else if (email[i] + email[i + 1] == "ex") {
      return "ex";
    } else if (email[i] + email[i + 1] == "ci") {
      return "ci";
    }
    return "NONE";
  }

  final firestoreInstance = FirebaseFirestore.instance;

  TextStyle textStyle1 = const TextStyle(color: Colors.white, fontSize: 20.0);
  TextStyle textStyle2 = const TextStyle(fontSize: 20.0);
  TextStyle textStyle4 = const TextStyle(fontSize: 18.0);
  TextStyle textStyle3 = const TextStyle(fontSize: 26.0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Supervisor Login",
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
          iconTheme: IconThemeData(color: Colors.brown),
        ),
        drawer: HODDrawer(textStyle3: textStyle3, textStyle2: textStyle2),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("supervisor")
              .doc("muk")
              .collection('students')
              .doc("attendance")
              .collection("${DateTime.now().month.toString()}-${DateTime.now().year.toString()}")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Text("Empty");
            }
            if (snapshot.hasData) {
              print("Total objects: ${snapshot.data!.docs.length}");
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, int index) {
                  Map<String, dynamic> docData =
                  snapshot.data!.docs[index].data();
                  if (docData.isEmpty) {
                    return const Center(
                      child: Text(
                        "Document is Empty",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  num totalAttendance = docData["totalAttendance"];
                  num id = docData["id"];
                  String name  = docData["name"];
                  // String name = docData["name"];
                  // String guide = docData["guide"];
                  // return columnHOD(
                  //   guide: guide,
                  //   name: name,
                  //   id: id,
                  //   gpa: gpa,
                  //   year: year,
                  // );
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Colors.blue,
                              child: Text("total attendance: $totalAttendance"),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Colors.blue,
                              child: Text("id: $id"),
                            ),
                            Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.blue,
                                child: Text(name)
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Text("No data");
            }
          },
        ),
        // body: ListView.builder(
        //   itemCount: 6,
        //   itemBuilder: (context, int index) {
        //     return columnHOD();
        //   },
        // ),
      ),
    );
  }

  Widget columnHOD(
      {required String guide,
        required String name,
        required num id,
        required num gpa,
        required num year}) {
    TextStyle textStyle1 = const TextStyle(color: Colors.white, fontSize: 20.0);
    TextStyle textStyle2 = const TextStyle(fontSize: 20.0);
    TextStyle textStyle4 = const TextStyle(fontSize: 18.0);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10.0)),
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.all(10.0),
            title: Text(
              "Name: $name",
              style: textStyle2,
            ),
            backgroundColor: Colors.blue[100],
            collapsedBackgroundColor: Colors.blue[100],
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      id.toString(),
                      style: textStyle4,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "Guide: $guide",
                      style: textStyle4,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "Year: ${year.toString()}",
                      style: textStyle4,
                    ),
                  ),
                  // const SizedBox(height: 6.0),
                  // Container(
                  //   padding: const EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: Text(
                  //     "Admission year: 2022",
                  //     style: textStyle4,
                  //   ),
                  // ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "GPA: ${gpa.toString()}",
                      style: textStyle4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      alertDialog();
                    },
                    style: TextButton.styleFrom(
                      // elevation: 0.0
                    ),
                    child: Card(
                      color: Colors.red,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 4.5,
                          // MediaQuery.of(context).size.width / 4.9,
                          child: Text(
                            "Deny",
                            style: textStyle1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(shadowColor: Colors.blue[100]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      color: Colors.green,
                      elevation: 3.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: Text(
                            "Approve",
                            style: textStyle1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

class HODDrawer extends StatelessWidget {
  const HODDrawer({
    Key? key,
    required this.textStyle3,
    required this.textStyle2,
  }) : super(key: key);

  final TextStyle textStyle3;
  final TextStyle textStyle2;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 20,
      child: ListView(
        // padding: const EdgeInsets.all(0.0),
        children: [
          UserAccountsDrawerHeader(
            // margin: EdgeInsets.zero,
            accountName: Text(
              "Nikhil Soni",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            //style: textStyle3),
            accountEmail: const Text(
              "nikhilsoni2910@gamil.com",
              style: TextStyle(fontSize: 15, color: Colors.black45),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.brown.shade100,
              child: Text(
                'N',
                style: TextStyle(
                    color: Colors.brown[700],
                    fontSize: 25,
                    fontWeight: FontWeight.normal),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.brown.shade700, Colors.white])),
          ),
          ListTile(
            leading: const Icon(
              Icons.person_pin,
              size: 30,
            ),
            title: Text(
                "Profile",
                style : TextStyle(fontSize: 16)

            ),
            onTap: () {
              // Navigator.push(
              //     context,

              //     /// Add Karo Idhar
              //     MaterialPageRoute(builder: (context) => const HODRecords()));
            },
          ),
          Divider(
            height: 0.1,
            color: Colors.black26,
          ),
          ListTile(
            leading: const Icon(
              Icons.fact_check,
              size: 30.0,
            ),
            title: Text(
                "Take Attendance",
                style : TextStyle(fontSize: 16)

            ),
            onTap: () {
              //   Navigator.push(
              //      context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
          Divider(
            height: 0.1,
            color: Colors.black26,
          ),ListTile(
            leading: const Icon(
              Icons.assignment_rounded,
              size: 30.0,
            ),
            title: Text(
                "View Attendance",
                style : TextStyle(fontSize: 16)

            ),
            onTap: () {
              // Navigator.push(
              //   //  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
          Divider(
            height: 0.1,
            color: Colors.black26,
          ),

          ListTile(
            leading: const Icon(
              Icons.list,
              size: 30.0,
            ),
            title: Text(
                "View Records",
                style : TextStyle(fontSize: 16)

            ),
            onTap: () {
              Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => const SupervisorRecords()));
            },
          ),
          Divider(
            height: 0.1,
            color: Colors.black26,
          ),

          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              size: 30.0,
            ),
            title: Text(
                "Log Out",
                style : TextStyle(fontSize: 16)

            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
          Divider(
            height: 0.1,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}
