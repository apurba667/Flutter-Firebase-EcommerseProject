import 'package:firebase/admin/adminWork.dart';
import 'package:firebase/admin/admin_delete_update_mobile.dart';
import 'package:firebase/loginpage.dart';
import 'package:firebase/screens/bottonav.dart';
import 'package:firebase/screens/mobile.dart';
import 'package:firebase/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
