import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password reset link has been sent! Check your email'),
          );
        },);
    } on FirebaseAuthException catch (e) {
      print(e);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in without password',
        textAlign: TextAlign.right,
        style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
             children: [
               SizedBox(width: 25),
               Text(
                 'Email or username',
                 textAlign: TextAlign.left,
                 style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
               ),
             ],
          ),

          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailcontroller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown, width: 1)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 2),
                ),
                hintText: 'Email',
                fillColor: Colors.white70,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
            onPressed: passwordReset,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Reset Password',),
            color: Colors.brown[200],
          ),
        ],
      ),
    );
  }
}
