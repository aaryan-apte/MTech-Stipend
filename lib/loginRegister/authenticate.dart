import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtech_stipend/pages/hod/hod_records.dart';

import 'login.dart';

class Authenticate2 extends StatelessWidget {
  const Authenticate2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data?.email);
            return HODRecords();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    ),
  );
}