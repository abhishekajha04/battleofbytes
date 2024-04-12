import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:battle_of_bytes_aution/visitors_dashboard.dart';
import 'package:battle_of_bytes_aution/visitors_registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VisitorsLoginScreen extends StatefulWidget {
  const VisitorsLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return VisitorsLoginScreenState();
  }
}

final visitorloginusernameTextController = TextEditingController();
final visitorloginpasswordTextController = TextEditingController();

class VisitorsLoginScreenState extends State<VisitorsLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor('#EAF2F4'),
      body: SafeArea(
          child: Center(
        child: Container(
          height: 500,
          width: 500,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: hexToColor('#B3CDE0')),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Login To Continue Visitor Login Page',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              fillDetails(
                  'Enter your user id', visitorloginusernameTextController),
              fillDetails('Enter Password', visitorloginpasswordTextController,
                  padding: 30),
              const SizedBox(
                height: 60,
              ),
              buildButton('Click Here To Continue', () {
                visitorLogin(context, visitorloginusernameTextController.text,
                    visitorloginpasswordTextController.text);
              },
                  bottomMargin: 0,
                  fontSize: 14,
                  textColor: '#FFFFFF',
                  height: 55,
                  leftMargin: 55,
                  rightMargin: 55),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const VisitorRegisterScreen();
                  }));
                },
                child: Text(
                  'Click here to signup',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[800]),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

void visitorLogin(BuildContext context, String email, String password) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) {
    navigateVisitorDashboard(context);
  }).onError((error, stackTrace) {
    debugPrint('Something Error: ${error.toString()}');
  });
}

void navigateVisitorDashboard(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const VisitorDashboardScreen();
  }));
}
