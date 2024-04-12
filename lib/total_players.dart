import 'package:battle_of_bytes_aution/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalPlayerScreen extends StatefulWidget {
  const TotalPlayerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TotalPlayerScreenState();
  }
}

class TotalPlayerScreenState extends State<TotalPlayerScreen> {
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
          child: const PlayerList(),
        ),
      )),
    );
  }
}

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
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

              return Card(
                child: ListTile(
                  title: Text(userData['name'] ?? ''),
                  subtitle: Text(
                      'Team Chocolate Bided: ${userData['total_choclate']}, Team Name: ${userData['team_name']}, Roll No: ${userData['roll_no']}'),
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
