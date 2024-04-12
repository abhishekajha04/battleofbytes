import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int? teacherChocolates;
String? teacherId;
String? teamName;

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TeacherDashboardScreenState();
  }
}

class TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: hexToColor('#EAF2F4'),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              width: 600,
              margin: const EdgeInsets.only(top: 100, bottom: 100),
              child: const UserList(),
            ),
          )
        ],
      )),
    );
  }

  Future<void> getUserDetails() async {
    try {
      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get a reference to the Firestore collection where user data is stored
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('teacher');

        // Query the collection to get the document corresponding to the current user's UID
        DocumentSnapshot snapshot = await usersCollection.doc(user.uid).get();

        // Check if the document exists
        if (snapshot.exists) {
          // Extract user data from the document
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;

          setState(() {
            teacherId = user.uid;
            teacherChocolates = userData['total_choclates'];
            teamName = userData['team_name'];
          });
          // Print or use user data as needed
          debugPrint('User Name: ${userData['name']}');
          debugPrint('Team Name: ${userData['team_name']}');
          debugPrint('Total Choclatees: ${userData['total_choclates']}');
          debugPrint('Team Player: ${userData['total_player']}');
          debugPrint('Total Points: ${userData['total_points']}');
        } else {
          debugPrint('User document does not exist');
        }
      } else {
        debugPrint('No user logged in');
      }
    } catch (error) {
      debugPrint('Error retrieving user details: $error');
    }
  }
}

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('student').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> userData =
                  document.data() as Map<String, dynamic>;
              String userId = document.id;
              return Card(
                child: ListTile(
                  title: Text(userData['name'] ?? ''),
                  subtitle: Text(
                      'Total Choclates: ${userData['total_choclate']}, Team Name: ${userData['team_name']}'),
                  onTap: () {
                    // Show a dialog to input the new name
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController newChocolateController =
                            TextEditingController();
                        return AlertDialog(
                          title: const Text('Bid Players'),
                          content: TextField(
                            controller: newChocolateController,
                            decoration: const InputDecoration(
                              labelText: 'No. of Chocolates',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                int newTotalChocolate = int.tryParse(
                                        newChocolateController.text.trim()) ??
                                    0;
                                int studentChocolates =
                                    userData['total_choclate'];
                                updateTotalChocolate(
                                    context,
                                    userId,
                                    newTotalChocolate,
                                    studentChocolates); // Update the user's total chocolate
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No users found.'),
          );
        }
      },
    );
  }

  void updateTotalChocolate(BuildContext context, String userId,
      int newTotalChocolate, int studentChocolate) {
    debugPrint('Student Choclates: $studentChocolate');
    if (studentChocolate < newTotalChocolate) {
      // Update the user's name in Firestore

// Check if teacherChocolates is greater than 0
      if (teacherChocolates != null &&
          teacherChocolates! - newTotalChocolate > 0) {
        // Perform some action
        // Update the user's total chocolate in Firestore
        FirebaseFirestore.instance.collection('student').doc(userId).update({
          'total_choclate': newTotalChocolate,
          'team_name': teamName
        }).then((value) {
          // Show a success message or perform any other action upon successful update
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Total chocolate updated successfully')),
          );
        }).catchError((error) {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update total chocolate: $error')),
          );
        });
        FirebaseFirestore.instance.collection('teacher').doc(teacherId).update({
          'total_choclates': teacherChocolates! - newTotalChocolate,
        }).then((value) async {
          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('teacher');
          DocumentSnapshot snapshot =
              await usersCollection.doc(teacherId).get();
          if (snapshot.exists) {
            // Extract user data from the document
            Map<String, dynamic> userData =
                snapshot.data() as Map<String, dynamic>;

            setState(() {
              teacherChocolates = userData['total_choclates'];
            });
            // Print or use user data as needed
          } else {
            debugPrint('User document does not exist');
          }
          // Show a success message or perform any other action upon successful update
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Name updated successfully')),
          );
        }).catchError((error) {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update name: $error')),
          );
        });
      } else {
        // Perform some other action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You do not have this much chocolate')),
        );
      }
    } else {
      debugPrint('Please Add higher Bidding Choclates');
    }
  }
}
