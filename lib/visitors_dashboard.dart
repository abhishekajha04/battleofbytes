import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int? votingStatus;
String? visitorUid;

class VisitorDashboardScreen extends StatefulWidget {
  const VisitorDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return VisitorDashboardScreenState();
  }
}

class VisitorDashboardScreenState extends State<VisitorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    getVisitorDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: hexToColor('#EAF2F4'),
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: 600,
          margin: const EdgeInsets.only(top: 100, bottom: 100),
          child: const UserList(),
        ),
      )),
    );
  }

  Future<void> getVisitorDetails() async {
    try {
      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get a reference to the Firestore collection where user data is stored
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('visitors');

        // Query the collection to get the document corresponding to the current user's UID
        DocumentSnapshot snapshot = await usersCollection.doc(user.uid).get();

        // Check if the document exists
        if (snapshot.exists) {
          // Extract user data from the document
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;

          setState(() {
            visitorUid = user.uid;
            votingStatus = userData['voting'];
          });
          // Print or use user data as needed
          debugPrint('User Name: ${userData['name']}');
          debugPrint('Voting Status: ${userData['voting']}');
          debugPrint('Current Year: ${userData['year']}');
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
      stream: FirebaseFirestore.instance.collection('teacher').snapshots(),
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
                      'Team Name: ${userData['team_name']}, Total Points: ${userData['total_points']}'),
                  onTap: () {
                    updateVote(context, userId, userData['total_points']);
                    // Show a dialog to input the new name
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

  void updateVote(
    BuildContext context,
    String userId,
    int totalVote,
  ) {
    debugPrint('Total Choclates: $totalVote');

// Check if teacherChocolates is greater than 0
    if (votingStatus != null && votingStatus == 0) {
      // Perform some action
      // Update the user's total chocolate in Firestore
      FirebaseFirestore.instance.collection('teacher').doc(userId).update({
        'total_points': totalVote + 1,
      }).then((value) {
        // Show a success message or perform any other action upon successful update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Total vote updated successfully')),
        );
      }).catchError((error) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update votes: $error')),
        );
      });
      FirebaseFirestore.instance.collection('visitors').doc(visitorUid).update({
        'voting': 1,
      }).then((value) async {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('visitors');
        DocumentSnapshot snapshot = await usersCollection.doc(visitorUid).get();
        if (snapshot.exists) {
          // Extract user data from the document
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;

          setState(() {
            votingStatus = userData['voting'];
          });
          // Print or use user data as needed
        } else {
          debugPrint('User document does not exist');
        }
        // Show a success message or perform any other action upon successful update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vote updated successfully')),
        );
      }).catchError((error) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update vote: $error')),
        );
      });
    } else {
      // Perform some other action
      debugPrint('No votings Left');
    }
  }
}
