import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key, required this.email});
  final String email;
  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {

  EmailAuth emailAuth =  EmailAuth(sessionName: "MTech Stipend");
  bool otpSent = false;

  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: widget.email, otpLength: 5
    );
    setState(() {
      otpSent = true;
    });
  }

  bool isValidated() {
     bool result = emailAuth.validateOtp(
        recipientMail: widget.email,
        userOtp: otpController.value.text);
     return result;
  }
  @override
  void initState() {
    // TODO: implement initState
    sendOtp();
  }

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[100]),
                margin: const EdgeInsets.only(
                    top: 54.0, left: 11.0, right: 11.0, bottom: 54.0),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "An OTP is sent to",
                        style: TextStyle(color: Colors.black, fontSize: 23.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.email,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextField(
                          maxLength: 5,
                          controller: otpController,
                          decoration: InputDecoration(
                              hintText: "Enter OTP here",
                              hintStyle: TextStyle(color: Colors.blue[400])),
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextButton(
                          onPressed: () {
                            // addIncome();
                            bool res = isValidated();
                            if(res){
                              print("Hare Krishna");
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Validate",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
