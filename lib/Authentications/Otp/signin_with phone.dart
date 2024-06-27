import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/Otp/Otp_verification.dart';
import 'package:foodplanets/components/Round_button.dart';
import 'package:foodplanets/components/utils.dart';

class signinwithphone extends StatefulWidget {
  const signinwithphone({super.key});

  static String verify ="";

  @override
  State<signinwithphone> createState() => _signinwithphoneState();
}

class _signinwithphoneState extends State<signinwithphone> {
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  TextEditingController phonecontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/undraw_Mobile_login_re_9ntv.png",height: 150,width: 150,),
            SizedBox(height: 20,),
            Text("Phone Verification",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We need to register your phone before getting\n started!",
              style: TextStyle(fontSize: 14.0,),
            textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(

                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.purpleAccent),
                            ),
                            hintText: "+92  |  Phone",
                            helperText: "92+4398320345",
                            suffixIcon:  Icon(
                              Icons.phone,
                              color: Color(0xff48CEBE),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter phone number";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RoundButton(
                      title: "send OTP code",
                      loading: loading,
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        _auth.verifyPhoneNumber(
                            phoneNumber: "${phonecontroller.text.toString()}",
                            verificationCompleted: (_) {
                              setState(() {
                                loading = false;
                              });
                            },
                            verificationFailed: (e) {
                              Utils().toastMessage(e.toString());
                              setState(() {
                                loading = false;
                              });
                            },
                            codeSent: (String verificationId, int? token) {
                              signinwithphone.verify=verificationId;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => verifyOTP(
                                        verificationId:verificationId,
                                      )));
                              setState(() {
                                loading = false;
                              });
                            },
                            codeAutoRetrievalTimeout: (e) {
                              Utils().toastMessage.toString();
                              setState(() {
                                loading = false;
                              });
                            });
                      }),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
