import 'dart:math';

import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminDashboardScreenState();
  }
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            buildButton('Start Bidding', () {
              startBidding();
            }),
            buildButton('End Bidding', () {
              endBiding();
            }),
            buildButton('SignUpStudent', () {
              signUpStudent('abhi11@gmail.com', '123456', 'Abhi5', 'first',
                  'btech/25153/23');
            })
          ],
        )),
      ),
    );
  }
}

void startBidding() async {
  await FirebaseFirestore.instance
      .collection('biddingStaus')
      .doc('vdZI01EyLWRv65WDiV0m')
      .update({'biddingStatus': 1}).then((value) => {
            log(1),
          });
}

void endBiding() async {
  await FirebaseFirestore.instance
      .collection('biddingStaus')
      .doc('vdZI01EyLWRv65WDiV0m')
      .update({'biddingStatus': 0}).then((value) => {
            log(0),
          });
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
