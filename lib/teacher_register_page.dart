import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeeacherRegisterScreen extends StatefulWidget {
  const TeeacherRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TeeacherRegisterScreenState();
  }
}

final adminTextController = TextEditingController();
final adminusernameTextController = TextEditingController();
final adminpasswordTextController = TextEditingController();
final adminnameController = TextEditingController();
final adminteamNameTextController = TextEditingController();

class TeeacherRegisterScreenState extends State<TeeacherRegisterScreen> {
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
                fillDetails(
                    'Enter Admin Provided Password', adminTextController,
                    width: double.infinity),
                fillDetails('Enter your email', adminusernameTextController,
                    width: double.infinity),
                fillDetails('Enter Password', adminpasswordTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Name', adminnameController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Team Name', adminteamNameTextController,
                    padding: 30, width: double.infinity),
                const SizedBox(
                  height: 60,
                ),
                buildButton('Click Here To SignUp', () {
                  verifyAdminPassword();
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

void verifyAdminPassword() {
  if (adminTextController.text == 'Abhishek@2004') {
    signUpTeacher(
        adminusernameTextController.text,
        adminpasswordTextController.text,
        adminnameController.text,
        adminteamNameTextController.text);
  } else {
    debugPrint('Admin Password is not correct');
  }
}

void signUpTeacher(
  String email,
  String password,
  String name,
  String teamname,
) async {
  try {
    // Create user with Firebase Authentication
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get user ID from the created user
    final uid = userCredential.user!.uid;

    // Create a reference to the user document in Firestore
    final userDocRef =
        FirebaseFirestore.instance.collection('teacher').doc(uid);

    // Add user data (name and city) to the document
    await userDocRef.set({
      'name': name,
      'team_name': teamname,
      'total_choclates': 50,
      'total_points': 0,
      'total_player': 0,
    });

    debugPrint('User Created and Added to Firestore');
  } on FirebaseAuthException catch (error) {
    debugPrint("Authentication Error: ${error.code}");
  } catch (error) {
    debugPrint("Error: ${error.toString()}");
  }
}
