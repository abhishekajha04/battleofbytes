import 'package:battle_of_bytes_aution/bidding_error.dart';
import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/teacher_dashboard_screen.dart';
import 'package:battle_of_bytes_aution/teacher_register_page.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int? data;

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TeacherLoginScreenState();
  }
}

final teacherloginusernameTextController = TextEditingController();
final teacherloginpasswordTextController = TextEditingController();

class TeacherLoginScreenState extends State<TeacherLoginScreen> {
  @override
  void initState() {
    super.initState();
    getBiddingStatus(); // Call your function here
  }

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
                'Login To Continue Teachers Admin Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              fillDetails(
                  'Enter your email', teacherloginusernameTextController),
              fillDetails('Enter Password', teacherloginpasswordTextController,
                  padding: 30),
              const SizedBox(
                height: 60,
              ),
              buildButton('Click Here To Continue', () {
                teacherLogin(context, teacherloginusernameTextController.text,
                    teacherloginpasswordTextController.text);
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
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const TeeacherRegisterScreen();
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

void getBiddingStatus() async {
  try {
    // Get a DocumentSnapshot of the bidding status document
    final docSnapshot = await FirebaseFirestore.instance
        .collection('biddingStaus')
        .doc('vdZI01EyLWRv65WDiV0m')
        .get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Extract the biddingStatus value
      final biddingStatus = docSnapshot.data()!['biddingStatus'];
      data = biddingStatus;
      // Use the retrieved biddingStatus data (e.g., conditional logic, update UI)
      debugPrint('Bidding Status: $biddingStatus'); // Example usage
    } else {
      // Handle the case where the document doesn't exist
      debugPrint('Bidding status document not found!');
    }
  } catch (error) {
    debugPrint("Error fetching bidding status: $error");
  }
}

void teacherLogin(BuildContext context, String email, String password) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) {
    navigateScreen(context);
  }).onError((error, stackTrace) {
    debugPrint('Something Error: ${error.toString()}');
  });
}

void navigateScreen(BuildContext context) {
  if (data == 1) {
    navigateTeacherDashboardScreen(context);
  }
  if (data == 0) {
    navigateBiddingErrorScreen(context);
  } else {
    debugPrint('  ');
  }
}

void navigateTeacherDashboardScreen(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const TeacherDashboardScreen();
  }));
}

void navigateBiddingErrorScreen(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const BiddingErrorScreen();
  }));
}
