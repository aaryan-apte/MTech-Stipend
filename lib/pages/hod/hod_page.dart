import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/pages/hod/hod_records.dart';


class HODPage extends StatefulWidget {
  const HODPage({Key? key}) : super(key: key);

  @override
  State<HODPage> createState() => _HODPageState();
}

class _HODPageState extends State<HODPage> {
  TextEditingController reasonController = TextEditingController();

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
            "HOD - Student Requests",
            textAlign: TextAlign.center,
          ),
        ),
        drawer: HOD_Drawer(textStyle3: textStyle3, textStyle2: textStyle2),
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ExpansionTile(
                    childrenPadding: const EdgeInsets.all(10.0),
                    title: Text(
                      "Aaryan Apte",
                      style: textStyle2,
                    ),
                    backgroundColor: Colors.blue[100],
                    collapsedBackgroundColor: Colors.blue[100],
                    // collapsedTextColor: Colors.white,
                    // textColor: Colors.white,
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
                                "ID: 211070082",
                                style: textStyle4,
                              )),
                          const SizedBox(height: 6.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Guide: Dr. Manasi Kulkarni",
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
                              "Year: 2023",
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
                              "Admission year: 2022",
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
                              "GPA: 9.23",
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
                                  width:
                                      MediaQuery.of(context).size.width / 4.9,
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
                            style: TextButton.styleFrom(
                                shadowColor: Colors.blue[100]),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              color: Colors.green,
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 4.9,
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
          },
        ),
      ),
    );
  }
}



class HOD_Drawer extends StatelessWidget {
  const HOD_Drawer({
    Key? key,
    required this.textStyle3,
    required this.textStyle2,
  }) : super(key: key);

  final TextStyle textStyle3;
  final TextStyle textStyle2;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue[50],
      elevation: 6.0,
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text("Nikhil Soni", style: textStyle3),
              accountEmail: Text(
                "nikhilsoni2910@gamil.com",
                style: const TextStyle(fontSize: 15),
              ),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: AssetImage(imageloc),
              // ),
            ),
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              size: 38.0,
            ),
            title: Text(
              "Profile",
              style: textStyle2,
            ),
            onTap: () {
              // Navigator.push(
              //     context,

              //     /// Add Karo Idhar
              //     MaterialPageRoute(builder: (context) => const HODRecords()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.timelapse_rounded,
              size: 38.0,
            ),
            title: Text(
              "View Records",
              style: textStyle2,
            ),
            onTap: () {
              Navigator.push(
                  context,

                  /// Add Karo Idhar
                  MaterialPageRoute(builder: (context) => const HODRecords()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              size: 38.0,
            ),
            title: Text(
              "Log Out",
              style: textStyle2,
            ),
            onTap: () {},
            //onTap: Navigator.push(context,            /// Add Karo Idhar
            //MaterialPageRoute(builder: (context) => FacultyPage())),
          )
        ],
      ),
    );
  }
}
