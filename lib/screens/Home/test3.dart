import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class GD extends StatelessWidget {
  const GD({Key? key}) : super(key: key);

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
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    fillColor: Colors.yellow,
                    hoverColor: Colors.yellow,
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
                  decoration: const InputDecoration(
                    labelText: "Enter Your Password",
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        decorationColor: Color(0xFF05486F)),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    color: const Color(0xFFC3E7C9),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    onPressed: () {
                      print('text');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
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
                      onTap: () {},
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
                      onPressed: () {
                        print('click');
                      }),
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
