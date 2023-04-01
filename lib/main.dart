import 'package:flutter/material.dart';
import 'package:mtech_stipend/pages/hod/hod_page.dart';
// import 'package:mtech_stipend/pages/hod/hod/hod_page.dart';

void main() {
  runApp(StipendApp());
}
class StipendApp extends StatelessWidget {
  const StipendApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HODPage(),
      theme: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    );
  }
}
