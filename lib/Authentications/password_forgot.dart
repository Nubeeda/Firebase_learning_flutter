import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/login.dart';
import 'package:foodplanets/components/UIhelper.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailcontroler = TextEditingController();

  forgotpassword(String email) async {
    if (email == "") {
      return UIhelper.customAlertBox(context,
          "Please Enter your email first and then click Forgot password Button.");
    } else {
      await UIhelper.customAlertBox(context,
          "Password Reset Email has been sended to your email address.Please check it.");

      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Container(
         width: 200,
         height: 200,
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/undraw_Forgot_password_re_hxwm.png")),
         ),
       ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Forgot Password?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 10,),
        Center(
          child: Text(
            "Enter the email address you used"
                " when\n you joined and when you send your\n "
                "instructions to reset your password.",
            style: TextStyle(
              fontSize:12.0 ,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        UIhelper.customTextFormField(
          controller: emailcontroler,
          iconData: Icons.email,
          text: "Email",
          toHide: false,
        ),
        const SizedBox(
          height: 50.0,
        ),
        UIhelper.customButton(() {
          forgotpassword(emailcontroler.text.toString());
        }, "Continue"),
      ],
    ));
  }
}
