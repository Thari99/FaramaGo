import 'package:farmago/screens/Home/test.dart';
import 'package:farmago/screens/Home/test2.dart';
import 'package:farmago/screens/Home/test3.dart';
import 'package:farmago/screens/Navigation/navigation_provider.dart';
import 'package:farmago/screens/bayer/login-screen.dart';
import 'package:farmago/screens/bayer/signup-screen.dart';
import 'package:farmago/screens/farmer/login-screen.dart';
import 'package:farmago/screens/farmer/signup-screen.dart';
import 'package:farmago/screens/welcome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp( MyApp());
// }

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginB(),
    );
  }
}
