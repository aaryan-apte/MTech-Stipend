import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/pages/student/otp_verification.dart';
// import '../../bucket.dart';
import '../../loginRegister/authenticate.dart';
import '../supervisor/guide.dart';
// import 'guide.dart';

class StudentForm extends StatefulWidget {
  static String id = "/student_form";

  StudentForm({super.key});
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  String _selectedGuide = "Manasi";
  List<String> _selectedGuideList = [];
  Guide guide = Guide();

  @override
  void initState() {
    super.initState();
    // _selectedSubject = widget.guide.guideList.keys.first;
    // _selectedGuideList = widget.guide.guideList[_selectedSubject]!;
  }

  EmailAuth emailAuth = EmailAuth(sessionName: "MTech Stipend");

  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController registrationIDController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController hodController = TextEditingController();
  TextEditingController financialAssistanceSourceController =
      TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isFundedOther = false;

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  bool isVJTIian() {
    String email = emailController.value.text.toLowerCase();
    int i = 0;
    while (email[i] != '@') {
      i = i + 1;
    }
    i = i + 4;
    if (email[i] == 'v' &&
        email[i + 1] == 'j' &&
        email[i + 2] == 't' &&
        email[i + 3] == 'i') {
      return true;
    }
    return false;
  }

  Future<void> addUser() async {
    Map<String, dynamic> map1 = {};
    if (isFundedOther == true) {
      map1 = {
        "branch": branchController.text.trim(),
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "registrationID": registrationIDController.text.trim(),
        "year": int.parse(yearController.text.trim()),
        "amount": int.parse(amountController.text.trim()),
        "supervisor": supervisorController.text.trim(),
        "hod": hodController.text.trim(),
        "fundedOther": isFundedOther,
        "assistanceFrom": financialAssistanceSourceController.text.trim(),
      };
    } else {
      map1 = {
        "branch": branchController.text.trim(),
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "registrationID": registrationIDController.text.trim(),
        "year": int.parse(yearController.text.trim()),
        "supervisor": supervisorController.text.trim(),
        "hod": hodController.text.trim(),
      };
    }
    final users = FirebaseFirestore.instance
        .collection('branch')
        .doc(getBranch(emailController.text.trim()))
        .collection('students')
        .doc(emailController.text.trim())
        .collection("applications")
        .doc('details')
        .set(map1);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? email = auth.currentUser?.email;
    // await users.doc(uid).set({
    //   'date': DateTime.now(),
    // });
  }

  String getBranch(String email) {
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

  final _branch = [
    'Civil (Environmental)',
    'Civil (Structural)',
    'Civil (Construction)',
    'Electrical (Power System)',
    'Electrical (Control System)',
    'Electronics (Power System)',
    'Electronics & Telecom',
    'Production',
    'Project Management',
    'Computer',
    'Computer (NIMS)',
    'Computer (Software )',
    'Mechanical (Machine Design)',
    'Mechanical (Automobile)',
    'Mechanical (Thermal)',
    'Mechanical (CAD/CAM)',
    'Textile Technology',
  ];
  Map<String, String> guideMap = {
    "Civil (Environmental)": 'civilEnvironmental',
    'Civil (Structural)': "civilStructural",
    'Civil (Construction)': 'civilConstruction',
    "Electrical (Power System)": "electricalPowerSystem",
    'Electrical (Control System)': "electricalControlSystem",
    "Electronics (Power System)": "electronicsPowerSystem",
    'Electronics & Telecom': "extc",
    "Production": "production",
    'Project Management': 'projectManagement',
    'Computer': 'computer',
    'Computer (NIMS)': 'computerNIMS',
    'Computer (Software)': "computerSoftware",
    'Mechanical (Machine Design)': "mechanicalMD",
    'Mechanical (Automobile)': "mechanicalAuto",
    'Mechanical (Thermal)': "mechanicalThermal",
    "Mechanical (CAD/CAM)": 'mechanicalCADCAM',
    'Textile Technology': "textileTech"
  };




  void signUp() {
    final isValid = formKey.currentState!.validate();
    if (isValid == false) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text.trim(),
    //       password: passwordController.text.trim());
    // } on FirebaseAuthException catch (e) {
    //   print(e);
    // }
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((userCreds) {
      addUser().then((value) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully!")));
        Future.delayed(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Authenticate2()));
        });
      });
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      throw "error";
    });
  }

  final _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  // final String? _currentItemSelected = 'January';
  // final _year = [];
  // for(int i = int.parse(()DateTime.now().year.toString()) - 10; i < )
  final _year = [
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];
  String? _currentItemSelected2 = '2023';
  late String selectedGuide = guideMap.keys.first;

  String? currentBranch = 'Civil (Environmental)';
  final _finance = [
    'Yes',
    'No',
  ];
  String? isFundedOtherString = 'Yes';
  bool _shouldShowFin = false;
  @override
  Widget build(BuildContext context) {
    if (isFundedOtherString == "Yes") {
      _shouldShowFin = true;
    } else {
      _shouldShowFin = false;
    }
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Welcome!"),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: SizedBox(
                      width: 200,
                      height: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: nameController,
                      // obscureText: true,
                      autofocus: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: "What's your name?",
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      autofocus: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: "Choose a strong password",
                          prefixIcon: Icon(Icons.lock_person_rounded)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                      controller: emailController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'VJTI Email ID',
                          hintText: 'Enter your VJTI Email ID',
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: registrationIDController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Registration ID',
                          prefixIconColor: Colors.brown,
                          hintText: 'Enter your Registration ID',
                          prefixIcon: Icon(Icons.numbers)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Year',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                            items: _year.map((String dropDownStringItem2) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem2,
                                child: Text(
                                  dropDownStringItem2,
                                  style: const TextStyle(fontSize: 16.5),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected2) {
                              setState(() {
                                _currentItemSelected2 = newValueSelected2;
                              });
                            },
                            value: _currentItemSelected2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 350,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'M.Tech in',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 55, 71, 79),
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.school,
                              ),
                            ),
                            items: _branch.map((String dropDownStringItem3) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem3,
                                child: Text(
                                  dropDownStringItem3,
                                  style: const TextStyle(fontSize: 16.5),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected3) {
                              setState(() {
                                currentBranch = newValueSelected3;
                              });
                            },
                            value: currentBranch,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Other financial assistance',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 55, 71, 79),
                                    width: 20.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.monetization_on_rounded,
                              ),
                            ),
                            items: _finance.map((String dropDownStringItem4) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem4,
                                child: Text(
                                  dropDownStringItem4,
                                  style: const TextStyle(fontSize: 16.5),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected4) {
                              setState(() {
                                if (newValueSelected4 == "Yes") {
                                  isFundedOther = true;
                                  isFundedOtherString = "Yes";
                                } else {
                                  isFundedOtherString = "No";
                                }
                              });
                            },
                            value: isFundedOtherString,
                          ),
                        ),
                        // if (_currentItemSelected4 == "Yes") {}
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _shouldShowFin,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: financialAssistanceSourceController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Financial Assistance from',
                          hintText: 'Source of Financial Assistance',
                          prefixIcon: Icon(Icons.monetization_on),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _shouldShowFin,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                          hintText: 'Amount of Financial Assistance',
                          prefixIcon: Icon(Icons.money),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),


                  // DropdownButtonFormField(
                  //   value: _selectedGuide,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedGuide = value!;
                  //     });
                  //   },
                  //   items: guide.guideList.keys
                  //       .map((subject) => DropdownMenuItem(
                  //             child: Text(subject),
                  //             value: subject,
                  //           ))
                  //       .toList(),
                  //   decoration: const InputDecoration(
                  //     hintText: 'Select a subject',
                  //   ),
                  // ),


                  const SizedBox(height: 16.0),
                  const Text('Select a guide:'),
                  // DropdownButtonFormField(
                  //   value: selectedGuide,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedGuide = value!;
                  //     });
                  //   },
                  //   items: _selectedGuide != null
                  //       ? guide.guideList[_selectedGuide]
                  //           ?.map((guide) => DropdownMenuItem(
                  //                 value: guide,
                  //                 child: Text(guide),
                  //               ))
                  //           .toList()
                  //       : null,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Select a guide',
                  //   ),
                  // ),



                  // SizedBox(
                  // width: 310,
                  // child: DropdownButtonFormField<String>(
                  //   decoration: InputDecoration(
                  //     labelText: 'Guide',
                  //     border: OutlineInputBorder(
                  //       borderSide:
                  //           const BorderSide(color: Colors.blue, width: 2.0),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     prefixIcon: const Icon(
                  //       Icons.person,
                  //     ),
                  //   ),
                  //   hint: const Text("Hare Krishna!"),
                  //   value: _selectedSubject,
                  //   items: widget.guide.guideList["Computer"] as List<DropdownMenuItem<String>>?,
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedSubject = newValue;
                  //       _selectedSubjectValues =
                  //           widget.guide.guideList[newValue]!;
                  //     });
                  //   },
                  // ),
                  // child: DropdownButton<String>(
                  //   value: _selectedSubjectValues.isEmpty ? null : _selectedSubjectValues.first,
                  //   items: _selectedSubjectValues.map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedSubjectValues = [newValue!];
                  //     });
                  //   },
                  // ),
                  // child: DropdownButton<String>(
                  //   value: selectedGuide,
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       selectedGuide = newValue!;
                  //     });
                  //   },
                  //   items: guideMap.keys.map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // )
                  // child: DropdownButtonFormField<String>(
                  //   decoration: InputDecoration(
                  //     labelText: "Select Guide",
                  //     border: OutlineInputBorder(
                  //       borderSide: const BorderSide(
                  //           color: Color.fromARGB(255, 55, 71, 79),
                  //           width: 2.0),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     prefixIcon: const Icon(
                  //       Icons.school,
                  //     ),
                  //   ),
                  //   items: _branch.map((String dropDownStringItem3) {
                  //     return DropdownMenuItem<String>(
                  //       value: dropDownStringItem3,
                  //       child: Text(
                  //         dropDownStringItem3,
                  //         style: const TextStyle(fontSize: 16.5),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValueSelected3) {
                  //     setState(() {
                  //       currentBranch = newValueSelected3;
                  //     });
                  //   },
                  //   value: currentBranch,
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //   //padding: EdgeInsets.symmetric(horizontal: 15),
                  //   child: TextField(
                  //     controller: supervisorController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Supervisor',
                  //       hintText: "Supervisor's name",
                  //       prefixIcon: Icon(Icons.supervisor_account_outlined),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: hodController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'HOD',
                        hintText: "HOD's name",
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        const snackBar = SnackBar(
                            content: Text('Please enter your VJTI email ID'));
                        if (isVJTIian()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerification(
                                email: emailController.value.text,
                              ),
                            ),
                          );
                          signUp();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 21.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              )),
        ),
      ),
    );
  }
}
