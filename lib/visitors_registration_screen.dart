import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VisitorRegisterScreen extends StatefulWidget {
  const VisitorRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return VisitorRegisterScreenState();
  }
}

final visitorusernameTextController = TextEditingController();
final visitorpasswordTextController = TextEditingController();
final visitorameController = TextEditingController();
final visitoryearTextController = TextEditingController();

class VisitorRegisterScreenState extends State<VisitorRegisterScreen> {
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
                fillDetails('Enter your email', visitorusernameTextController,
                    width: double.infinity),
                fillDetails('Enter Password', visitorpasswordTextController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Name', visitorameController,
                    padding: 30, width: double.infinity),
                fillDetails('Enter Your Year', visitoryearTextController,
                    padding: 30, width: double.infinity),
                const SizedBox(
                  height: 60,
                ),
                buildButton('Click Here To SignUp', () {
                  signUpvisitor(
                      visitorusernameTextController.text,
                      visitorpasswordTextController.text,
                      visitorameController.text,
                      visitoryearTextController.text);
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

void signUpvisitor(
  String email,
  String password,
  String name,
  String year,
) async {
  try {
    // Create user with Firebase Authentication
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get user ID from the created user
    final uid = userCredential.user!.uid;

    // Create a reference to the user document in Firestore
    final userDocRef =
        FirebaseFirestore.instance.collection('visitors').doc(uid);

    // Add user data (name and city) to the document
    await userDocRef.set({
      'name': name,
      'year': year,
      'voting': 0,
    });

    debugPrint('User Created and Added to Firestore');
  } on FirebaseAuthException catch (error) {
    debugPrint("Authentication Error: ${error.code}");
  } catch (error) {
    debugPrint("Error: ${error.toString()}");
  }
}
