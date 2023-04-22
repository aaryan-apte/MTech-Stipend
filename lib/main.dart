import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/login.dart';
import 'package:mtech_stipend/pages/hod/hod_page.dart';
import 'package:mtech_stipend/pages/hod/hod_records.dart';
import 'package:mtech_stipend/pages/student/student_form.dart';
import 'package:mtech_stipend/pages/supervisor/supervisor_page.dart';
import 'package:mtech_stipend/splash_screen.dart';
// import 'package:mtech_stipend/pages/hod/hod/hod_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StipendApp());
}

class StipendApp extends StatelessWidget {
  const StipendApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    );
  }
}
