import 'package:connectivity/connectivity.dart';
import 'package:farmago/screens/Authentication/signup-screen.dart';

import 'package:farmago/screens/welcome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginB extends StatefulWidget {
  const LoginB({Key? key}) : super(key: key);

  @override
  State<LoginB> createState() => _LoginBState();
}

class _LoginBState extends State<LoginB> {

  void showSnackBar(String title,  BuildContext context ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),)));
  }


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController= TextEditingController();

  // bool _isLoading = false;

  void login() async {

    // setState(() {
    //   _isLoading = true;
    // });
    //
    // String res = await AuthController()
    //     .LoginUser(emailController.text, passwordController.text);
    // setState(() {
    //   _isLoading = false;
    // });
    // if (res != 'success') {
    //   showSnackBar(res, context);
    // } else {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => Welcomepage()));
    // }


  //   final user = (await FirebaseAuth.instance..signInWithEmailAndPassword(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   ).catchError((error) {
  //     showSnackBar(error.message, context);
  //   })).user;
  //
  //   if (user != null) {
  //     DatabaseReference userRef =
  //     FirebaseDatabase.instance.ref().child('users/${user.uid}');
  //
  //
  //     userRef.onValue.listen((DatabaseEvent event) {
  //       final data = event.snapshot.value;
  //       userRef;
  //     }); }
  //
  //     userRef.once().then((DataSnapshot snapshot) {
  //       if (snapshot!.value != null) {
  //         Navigator.of(context)
  //             .pushReplacement(
  //             MaterialPageRoute(builder: (_) => const HomePage()));
  //       }
  //     });
  //
  //
  //   Navigator.of(context)
  //       .pushReplacement(
  //       MaterialPageRoute(builder: (_) => const Welcomepage()));
  //

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        showSnackBar('Wrong password provided for that user.', context);
      }
    }
    Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Welcomepage()));
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFEAEED7),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFEAEED7),
        body: Container(
          // padding:  EdgeInsets.only(top: 10, left: 30, right: 30),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: GlobalKey<FormState>(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    controller: emailController,
                    // autofocus: false,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    // autofocus: false,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Enter Your Password",
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot your password?',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFC3E7C9),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No internet connectivity', context);
                            return;
                          }
                          if (!emailController.text.contains('@')) {
                            showSnackBar('please enter a valid email address', context);
                            return;
                          }
                          if (passwordController.text.length < 8) {
                            showSnackBar('please enter a valid password', context);
                            return;
                          }

                          login();
                        },
                        child: const Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Don’t have an account ? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> SignUpB()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 16,
                        // color: Colors.black,
                      )),
                      Text(
                        'or',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        indent: 10,
                        endIndent: 20,
                        // color: Colors.black,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: SignInButton(
                        imagePosition: ImagePosition.left,
                        buttonType: ButtonType.google,
                        buttonSize: ButtonSize.medium,
                        btnColor: const Color(0xFFC3E7C9),

                        // btnColor: Colors.white,
                        onPressed: signInWithGoogle),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

//
// class AuthController {
//   Future<String> LoginUser(
//       String email,
//       String password,
//       ) async {
//     String res = 'some error occured';
//     try {
//       if (email.isNotEmpty && password.isNotEmpty) {
//         UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: email, password: password);
//         res = 'success';
//         print(cred.user!.email);
//       } else {
//       }
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }
// }

