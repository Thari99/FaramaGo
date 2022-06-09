import 'package:farmago/screens/Home/test2.dart';
import 'package:farmago/screens/Authentication/login-screen.dart';
import 'package:farmago/screens/Authentication/signup-screen.dart';
import 'package:farmago/screens/Home/test4.dart';
import 'package:farmago/screens/bayer/Home/view_Product/view_item.dart';
import 'package:farmago/screens/farmer/Home/Post_upload-screen/upload-screen.dart';
import 'package:farmago/screens/farmer/Home/home.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_drawer_widget.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_provider.dart';
import 'package:farmago/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

// void main() {
//   runApp( MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
