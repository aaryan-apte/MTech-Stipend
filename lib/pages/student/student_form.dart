import 'package:flutter/material.dart';

class StudentForm extends StatefulWidget {
  static String id = "/student_form";
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  var _months = [
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
  var _year = [
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
  var _branch = [
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
  var _finance = [
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
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Welcome!"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  width: 200,
                  height: 15,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  // obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: "What's your name?",
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email ID',
                      hintText: 'Enter your email id',
                      prefixIcon: Icon(Icons.email)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Roll No.',
                      prefixIconColor: Colors.brown,
                      hintText: 'Enter your Roll No.',
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
                                BorderSide(color: Colors.brown, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month_outlined,
                          ),
                        ),
                        items: _months.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(fontSize: 16.5),
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
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                          ),
                        ),
                        items: _year.map((String dropDownStringItem2) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem2,
                            child: Text(
                              dropDownStringItem2,
                              style: TextStyle(fontSize: 16.5),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 55, 71, 79),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.school,
                          ),
                        ),
                        items: _branch.map((String dropDownStringItem3) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem3,
                            child: Text(
                              dropDownStringItem3,
                              style: TextStyle(fontSize: 16.5),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 55, 71, 79),
                                width: 20.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(
                            Icons.monetization_on_rounded,
                          ),
                        ),
                        items: _finance.map((String dropDownStringItem4) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem4,
                            child: Text(
                              dropDownStringItem4,
                              style: TextStyle(fontSize: 16.5),
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
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'HOD',
                      hintText: "HOD's name",
                      prefixIcon: Icon(Icons.supervised_user_circle_outlined)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
