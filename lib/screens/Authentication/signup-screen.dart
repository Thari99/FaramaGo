import 'package:connectivity/connectivity.dart';
import 'package:farmago/screens/Authentication/login-screen.dart';
import 'package:farmago/screens/welcome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpB extends StatefulWidget {
  @override
  State<SignUpB> createState() => _SignUpBState();
}

class _SignUpBState extends State<SignUpB> {

void showSnackBar(String title,  BuildContext context ) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title,
        textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),)));
  }

  bool _isLoading = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void registerUser() async {

    setState(() {
      _isLoading = true;
    });
    String res = await AuthController().register_user(
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      mobileNumberController.text,
      passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      showSnackBar('Congratulations Acccount has been created', context);
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute(builder: (_) => const Welcomepage()));
    }

    // Navigator.of(context)
    //     .pushReplacement(
    //     MaterialPageRoute(builder: (_) => const Welcomepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEAEED7),
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Create an account'),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      hintText: "First Name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decorationColor: Color(0xFF05486F)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      hintText: "Last Name",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decorationColor: Color(0xFF05486F)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decorationColor: Color(0xFF05486F)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            decorationColor: Color(0xFF05486F)),
                        prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '(+94)',
                              style: TextStyle(fontSize: 17),
                            ))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decorationColor: Color(0xFF05486F)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decorationColor: Color(0xFF05486F)),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
                      color: const Color(0xFFC3E7C9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () async {
                        var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          showSnackBar('No internet connectivity', context);
                          return;
                        }

                        if (firstNameController.text.length < 3) {
                          showSnackBar('Please provide a valid name', context);
                          return;
                        }
                        if (lastNameController.text.length < 3) {
                          showSnackBar('Please provide a valid name', context);
                          return;
                        }
                        if (!emailController.text.contains('@')) {
                          showSnackBar('Please provide a email address', context);
                          return;
                        }

                        if (mobileNumberController.text.length < 7) {
                          showSnackBar('Please provide a mobile number', context);
                          return;
                        }

                        if (passwordController.text.length < 8) {
                          showSnackBar(
                              'Password must be at least 8 characters', context);
                          return;
                        }

                        registerUser();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account ? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const LoginB()));
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class AuthController {
  Future<String> register_user(String firstname, String lastname, String email,
      String password, String phone) async {
    String res = 'some error occured';
    try {
      if (firstname.isNotEmpty &&
          lastname.isNotEmpty &&
          phone.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          'firstname': firstname,
          'lastname': lastname,
          'phoneNumber': phone,
          'email': email,
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
