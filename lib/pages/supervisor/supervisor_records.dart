import 'package:flutter/material.dart';

class SupervisorRecords extends StatefulWidget {
  const SupervisorRecords({Key? key}) : super(key: key);

  @override
  State<SupervisorRecords> createState() => _SupervisorRecordsState();
}

class _SupervisorRecordsState extends State<SupervisorRecords> {
  TextStyle textStyle1 = const TextStyle(color: Colors.black, fontSize: 17.0);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Records Page",
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
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, int index) {
            if(index % 2 == 0){
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    decoration:
                    BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10.0)),
                    child: ExpansionTile(
                      childrenPadding: const EdgeInsets.all(10.0),
                      title: Text("Aaryan Apte", style: textStyle1,),
                      backgroundColor: Colors.blue[100],
                      collapsedBackgroundColor: Colors.blue[100],
                      collapsedTextColor: Colors.white,
                      textColor: Colors.white,
                      // leading: Container(
                      //   // height: 100.0,
                      //   child: Center(
                      //     child: Text("Hare Krishna!"),
                      //   ),
                      // ),
                      children: const [
                        Text("DENIED\n", style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.w800),),
                        Text("Reason: Incorrect details.")

                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            }
            else{
              return Column(
                children: [
                  Container(

                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    decoration:
                    BoxDecoration(color: Colors.blue[100],borderRadius: BorderRadius.circular(10.0)),
                    child: ExpansionTile(
                      childrenPadding: const EdgeInsets.all(10.0),
                      title:  Text("Aaryan J Apte", style: textStyle1,),
                      backgroundColor: Colors.blue[100],
                      collapsedBackgroundColor: Colors.blue[100],
                      collapsedTextColor: Colors.white,
                      textColor: Colors.white,
                      // leading: Container(
                      //   // height: 100.0,
                      //   child: Center(
                      //     child: Text("Hare Krishna!"),
                      //   ),
                      // ),
                      children: const [
                        Text("APPROVED", style: TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
