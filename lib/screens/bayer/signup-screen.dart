import 'package:flutter/material.dart';

class SignUpB extends StatelessWidget {
  const SignUpB({Key? key}) : super(key: key);

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
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
                      color: const Color(0xFFC3E7C9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        print('text');
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account ? ',
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
