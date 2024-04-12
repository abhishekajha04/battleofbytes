import 'package:battle_of_bytes_aution/admin_dashboard_screen.dart';
import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:flutter/material.dart';

class AdminLoginPageScreen extends StatefulWidget {
  const AdminLoginPageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminLoginPageScreenState();
  }
}

class AdminLoginPageScreenState extends State<AdminLoginPageScreen> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

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
                'Login To Continue Admin Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              fillDetails('Enter Admin Id', usernameTextController),
              fillDetails('Enter Password', passwordTextController,
                  padding: 30),
              const SizedBox(
                height: 60,
              ),
              buildButton('Click Here To Continue', () {
                verifyLoginDetails(context, usernameTextController.text,
                    passwordTextController.text);
              },
                  bottomMargin: 0,
                  fontSize: 14,
                  textColor: '#FFFFFF',
                  height: 55,
                  leftMargin: 55,
                  rightMargin: 55)
            ],
          ),
        ),
      )),
    );
  }

  void verifyLoginDetails(
      BuildContext context, String username, String password) {
    debugPrint('UserName: $username, Password: $password');
    if (username == 'admin@bob.com' && password == '123456') {
      navigateAdminPanelDashboard(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error'),
              content:
                  Text('UserId or Password is incorrect. Please try again'),
            );
          });
    }
  }
}

void navigateAdminPanelDashboard(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const AdminDashboardScreen();
  }));
}
