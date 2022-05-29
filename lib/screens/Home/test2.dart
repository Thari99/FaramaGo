import 'package:farmago/screens/Home/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  State<AuthApp> createState() => _AuthAppState();
  static const String id='testing';
}

class _AuthAppState extends State<AuthApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth User'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(controller: emailController),
              TextField(controller: passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(child: Text('Sign Up'), onPressed: () {}),
              ElevatedButton(child: Text('Sign In'), onPressed: ()  async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                setState(() {});}),
              ElevatedButton(child: Text('Log Out'), onPressed: () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value) {
                  print("Created New Account");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
            ],
          )
            ],
          ),
        ),
      ),
    );
  }
}
