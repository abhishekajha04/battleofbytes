import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StudentLoginScreenState();
  }
}

final usernameTextController = TextEditingController();
final passwordTextController = TextEditingController();
final yearTextController = TextEditingController();
final rollNoTextController = TextEditingController();
final skillsTextController = TextEditingController();
final nameTextController = TextEditingController();

class StudentLoginScreenState extends State<StudentLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor('#EAF2F4'),
      body: SafeArea(
          child: Center(
              child: Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 100, bottom: 100),
            width: 800,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: hexToColor('#B3CDE0')),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Fill Details to participate in the competition',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                fillDetails('Enter your email', usernameTextController,
                    width: double.infinity),
                fillDetails('Enter Password', passwordTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Name', nameTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Year', yearTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Roll No.', rollNoTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Skills', skillsTextController,
                    padding: 30, width: double.infinity),
                const SizedBox(
                  height: 60,
                ),
                buildButton('Click Here To SignUp', () {
                  signUpStudent(
                      usernameTextController.text,
                      passwordTextController.text,
                      nameTextController.text,
                      yearTextController.text,
                      rollNoTextController.text);
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
              ],
            ),
          ),
        ),
      ))),
    );
  }
}

void signUpStudent(String email, String password, String name, String year,
    String rollNo) async {
  try {
    // Create user with Firebase Authentication
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get user ID from the created user
    final uid = userCredential.user!.uid;

    // Create a reference to the user document in Firestore
    final userDocRef =
        FirebaseFirestore.instance.collection('student').doc(uid);

    // Add user data (name and city) to the document
    await userDocRef.set({
      'name': name,
      'year': year,
      'roll_no': rollNo,
      'team_name': null,
      'total_choclate': 0,
    });

    debugPrint('User Created and Added to Firestore');
  } on FirebaseAuthException catch (error) {
    debugPrint("Authentication Error: ${error.code}");
  } catch (error) {
    debugPrint("Error: ${error.toString()}");
  }
}
