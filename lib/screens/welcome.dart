import 'package:farmago/screens/Authentication/login-screen.dart';
import 'package:farmago/screens/Home/test.dart';
import 'package:farmago/screens/Home/test2.dart';
import 'package:farmago/screens/bayer/Home/home.dart';
import 'package:farmago/screens/bayer/Navigation/navigation_drawer_widget.dart';
import 'package:farmago/screens/farmer/Home/home.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Welcomepage(),
  ));
}

class Welcomepage extends StatelessWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(140, 166, 186, 1.0),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/welcome-page/farmer.png'))),
                ),
                const SizedBox(
                  height: 75,
                ),
                Column(children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomePageF()));
                    },
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Farmer",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomePageB()));
                    },
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Bayer",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
