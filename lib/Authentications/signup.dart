import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/components/Round_button.dart';

import '../components/utils.dart';
import 'home.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: emailcontroller.text.toString(),
      password: passwordcontroller.toString(),
    )
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xffD9D9D9),
                    ),
                    labelText: "Email",
                    labelStyle: const TextStyle(
                        color: Color(0xffD9D9D9),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    helperText: "enter email e.g john@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xffD9D9D9),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                        color: Color(0xffD9D9D9),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    // helperText: "enter Password e.g 3544#64@rorefdh",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 50,
                ),
                RoundButton(
                  title: "SignUp",
                  onTap: () {
                    setState(() {
                      loading = loading;
                      if (_formkey.currentState!.validate()) {
                        signup();
                      }
                    });
                  },
                ),
                // SizedBox(
                //   height: 20,
                // ]),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(right: 30),
                //       width: 60,
                //       height: 60,
                //       decoration: BoxDecoration(
                //         color: Color(0xffF5F5F5),
                //         shape: BoxShape.circle,
                //       ),
                //       child: Center(child: Icon(Icons.facebook)),
                //     ),
                //     Container(
                //       width: 60,
                //       height: 60,
                //       decoration: BoxDecoration(
                //         color: Color(0xffF5F5F5),
                //         shape: BoxShape.circle,
                //       ),
                //       child: Center(
                //         child: Text(
                //           "G",
                //           style: TextStyle(
                //               fontSize: 30,
                //               fontWeight: FontWeight.bold,
                //               color: Color(0xffF07575)),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xff48CEBE),
                      ),
                      child: Text("Login"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
