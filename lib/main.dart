import 'package:battle_of_bytes_aution/admin_login_screen.dart';
import 'package:battle_of_bytes_aution/home_page_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDj6nxEzsQStUgZF57_U9XpVkczRfJJ43c",
    appId: "1:764152153053:web:1edd3eb06ed3e63f8e6c34",
    messagingSenderId: "764152153053",
    projectId: "battle-of-bytes",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battle of Bytes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) {
          return const HomePageScreen();
        },
        "/admin": (context) {
          return const AdminLoginPageScreen();
        }
      },
    );
  }
}
