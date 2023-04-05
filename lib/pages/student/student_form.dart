import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../loginRegister/authenticate.dart';

class StudentForm extends StatefulWidget {
  static String id = "/student_form";

  const StudentForm({super.key});
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController registrationIDController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController hodController = TextEditingController();
  TextEditingController financialAssistanceSourceController =TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  Future<void> addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String? uid = auth.currentUser?.email;
    await users.doc(uid).set({
      'date': DateTime.now(),
    });
  }
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
  String? _currentItemSelected = 'January';
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
  final _branch = [
    'Civil (Environmental)',
    'Civil (Structural)',
    'Civil (Construction)',
    'Electrical (Power System)',
    'Electrical (Control System)',
    'Electronis (Power System)',
    'Electronics & Telecom ',
    'Production ',
    'Project Management',
    'Computer ',
    'Computer (NIMS)',
    'Computer (Software )',
    'Mechanical (Machine Design)',
    'Mechanical (Automobile)',
    'Mechanical (Thermal)',
    'Mechanical (CAD/CAM)',
    'Textile Technology',
  ];
  String? _currentItemSelected3 = 'Civil (Environmental)';
  final _finance = [
    'Yes',
    'No',
  ];
  String? _currentItemSelected4 = 'Yes';
  bool _shouldShowFin = false;
  @override
  Widget build(BuildContext context) {
    if (_currentItemSelected4 == "Yes") {
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
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
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
                        width: 250,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Month',
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.brown, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: const Icon(
                              Icons.calendar_month_outlined,
                            ),
                          ),
                          items: _months.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(fontSize: 16.5),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
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
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Year',
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blue, width: 2.0),
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
                        width: 310,
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
                              _currentItemSelected3 = newValueSelected3;
                            });
                          },
                          value: _currentItemSelected3,
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
                              _currentItemSelected4 = newValueSelected4;
                            });
                          },
                          value: _currentItemSelected4,
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
                          prefixIcon: Icon(Icons.monetization_on)),
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
                          prefixIcon: Icon(Icons.money)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: supervisorController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Supervisor',
                        hintText: "Supervisor's name",
                        prefixIcon: Icon(Icons.supervisor_account_outlined)),
                  ),
                ),
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
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined)),
                  ),
                ),
                const SizedBox(height: 10),

                Center(
                  child: TextButton(
                    onPressed: (){},
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 21.0),),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
