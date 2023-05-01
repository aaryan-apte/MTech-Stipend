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
  TextStyle textStyle1 = const TextStyle(color: Colors.black, fontSize: 17.0);
  final TextEditingController _textMonth = TextEditingController();

  String monthPicked =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

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
                  final month =  showMonthYearPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                  });
                },
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  width: double.infinity,
                  child: StreamBuilder(
                    //stream: todo
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      print(monthPicked.toString());
                      if (snapshot.hasData && snapshot.data != null) {
                        print("Total Documents: ${snapshot.data!.docs.length}");
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

                              //String student name = todo

                              return Container(
                                height: 65.0,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 18.0, left: 13.0, right: 13.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 17.0,
                                    right: 17.0,
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child:
                                        const Text('//fetch student name here'),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'There are no records for $monthPicked',
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
            ],
          ),
        ),
      ),
    );
  }
}
