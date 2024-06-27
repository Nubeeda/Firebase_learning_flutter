import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/Otp/signin_with%20phone.dart';
import 'package:foodplanets/Authentications/home.dart';
import 'package:foodplanets/components/Round_button.dart';
import 'package:foodplanets/components/utils.dart';
import 'package:pinput/pinput.dart';

class verifyOTP extends StatefulWidget {
  final String verificationId;
  const verifyOTP({super.key, required this.verificationId});

  @override
  State<verifyOTP> createState() => _verifyOTPState();
}

class _verifyOTPState extends State<verifyOTP> {
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  TextEditingController phonecontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

      var code="";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 150,height: 150,decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/undraw_My_password_re_ydq7.png")),
            ),),
            SizedBox(height: 20,),
            Text("Phone Verification",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We need to register your phone before getting\n started!",
              style: TextStyle(fontSize: 14.0,),
              textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                Pinput(

                validator: (s) {
                  return s == '2222' ? null : 'Pin is incorrect';
                },
                  onChanged: (value){
                  code = value;
                  },
                  length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
                  // TextFormField(
                  //   controller: phonecontroller,
                  //   keyboardType: TextInputType.phone,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide(color: Colors.purpleAccent),
                  //     ),
                  //     hintText: "Enter OTP",
                  //     helperText: "35739457",
                  //     prefixIcon: Icon(
                  //       Icons.phone,
                  //       color: Color(0xff48CEBE),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Enter OTP";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  RoundButton(
                      title: "Verify phone number",
                      loading: loading,
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        final credential = PhoneAuthProvider.credential(
                            verificationId: signinwithphone.verify,
                            smsCode: code);
                        try {
                          await _auth.signInWithCredential(credential);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage.toString();
                        }
                      }),
                ],
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => signinwithphone()));
                },
                    child: Text("Edit phone number ?",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.bold,
                    color: Colors.black),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
