import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:mtech_stipend/loginRegister/login.dart';
import 'package:mtech_stipend/pages/student/student_form.dart';
import 'package:mtech_stipend/pages/supervisor/supervisor_records.dart';
// import 'package:mtech_stipend/loginRegister/login.dart';
// import 'package:mtech_stipend/pages/student/studentHome.dart';
// import 'package:mtech_stipend/pages/student/student_form.dart';
// import 'package:mtech_stipend/pages/supervisor/attendance.dart';
// import 'package:mtech_stipend/pages/supervisor/supervisor_page.dart';
// import 'package:mtech_stipend/splash_screen.dart';
// import 'package:mtech_stipend/pages/hod/hod_page.dart';
// import 'package:mtech_stipend/pages/supervisor/supervisor_page.dart';
// import 'package:mtech_stipend/pages/hod/hod/hod_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StipendApp());
}

class StipendApp extends StatelessWidget {
  const StipendApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      // GlobalMaterialLocalizations.delegate,
      // MonthYearPickerLocalizations.delegate,
      home: const SupervisorRecords(),
      // home: StudentForm(),
      theme: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    );
  }
}
