import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/loginRegister/login.dart';
import 'package:mtech_stipend/pages/supervisor/attendance.dart';
// import 'package:mtech_stipend/pages/hod/hod_page.dart';
// import 'package:mtech_stipend/pages/supervisor/supervisor_page.dart';
// import 'package:mtech_stipend/pages/hod/hod/hod_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StipendApp());
}

class StipendApp extends StatelessWidget {
  const StipendApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentList(),
      theme: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    );
  }
}
