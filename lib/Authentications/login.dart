import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/password_forgot.dart';
import 'package:foodplanets/Authentications/signup.dart';
import 'package:foodplanets/components/Round_button.dart';

import '../components/utils.dart';
import 'Otp/signin_with phone.dart';
import 'home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formkey=GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login(){
    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString(),
    ).then((value){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=>HomeScreen()));
      setState(() {
        loading=false;
      });
    }
    ).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email,color: Color(0xffD9D9D9),),
                        labelText: "Email",labelStyle:const TextStyle(color: Color(0xffD9D9D9),
                          fontSize: 20,fontWeight: FontWeight.w600),
                        helperText: "enter email e.g john@email.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value){
                        if(value! . isEmpty){
                          return "Enter email";
                        }else{
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 10,),

                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon:const Icon(Icons.remove_red_eye_outlined,color: Color(0xffD9D9D9),),
                        prefixIcon:const Icon(Icons.lock,color: Color(0xffD9D9D9),),
                        labelText: "Password",labelStyle:const TextStyle(color: Color(0xffD9D9D9),
                          fontSize: 20,fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter password";
                        }else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context)=>Forgotpassword()));
                          },
                          child: TextButton(
                            onPressed:(){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context)=>Forgotpassword()));
                            },
                            child:const  Text("Forgot Password?",style: TextStyle(
                              color: Color(0xff48CEBE),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,

                            ),),),
                        ),
                      ],
                    ),


                    Row(children: [
                      Container(
                        margin:const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        decoration:const BoxDecoration(
                          color: Color(0xffE9EDE5),
                        ),
                        child:const Center(
                          child: Icon(Icons.check,),
                        ),
                      ),
                      const Text("Remember Me",
                        style: TextStyle(fontWeight: FontWeight.w300,
                            fontSize: 16),)
                    ],),
                    const SizedBox(height: 30,),
                    RoundButton(
                      title: "LogIn",
                      onTap: () {
                        setState(() {
                          loading = loading;
                          if (_formkey.currentState!.validate()) {
                            login();
                          }
                        });
                      },
                    ),

                    // const SizedBox(height: 30,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       margin:const EdgeInsets.only(right: 30),
                    //       width: 60,
                    //       height: 60,
                    //       decoration:const BoxDecoration(
                    //         color: Color(0xffF5F5F5),
                    //         shape:  BoxShape.circle,
                    //       ),
                    //       child:const Center(child: Icon(Icons.facebook)),
                    //     ),
                    //     Container(
                    //       width: 60,
                    //       height: 60,
                    //       decoration:const BoxDecoration(
                    //         color: Color(0xffF5F5F5),
                    //         shape:  BoxShape.circle,
                    //       ),
                    //       child:const Center(child: Text("G",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                    //           color: Color(0xffF07575)),),
                    //       ),
                    //     ),],
                    // ),
                    const SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context)=>const SignupScreen()));
                          },style: TextButton.styleFrom(
                          foregroundColor:const Color(0xff48CEBE),
                        ),
                          child:const  Text("Sign up"),
                        ),

                      ],),

                  ],),
              ),
              const SizedBox(height: 50.0,),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const signinwithphone() ));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Center(
                    child: Text("Signin With Phone", style: TextStyle(
                      fontSize: 17,
                    ),),
                  ),
                ),
              ),

  ])

    ));
  }
}
