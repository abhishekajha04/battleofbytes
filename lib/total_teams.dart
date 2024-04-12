import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalTeamScreen extends StatefulWidget {
  const TotalTeamScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TotalTeamScreenState();
  }
}

class TotalTeamScreenState extends State<TotalTeamScreen> {
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
          child: const TeamList(),
        ),
      )),
    );
  }
}

class TeamList extends StatefulWidget {
  const TeamList({super.key});

  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
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

              return Card(
                child: ListTile(
                  title: Text(userData['team_name'] ?? ''),
                  subtitle: Text(
                      'Mentor Name: ${userData['name']}, Total Points: ${userData['total_points']}'),
                  onTap: () {
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
}
