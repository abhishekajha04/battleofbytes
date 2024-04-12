import 'package:flutter/material.dart';

class BiddingErrorScreen extends StatefulWidget {
  const BiddingErrorScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BiddingErrorScreenState();
  }
}

class BiddingErrorScreenState extends State<BiddingErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Bidding Not Started Yet'),
        ),
      ),
    );
  }
}
