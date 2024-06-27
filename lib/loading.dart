import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodplanets/Authentications/home.dart';
import 'package:foodplanets/Authentications/signup.dart';

import 'Authentications/login.dart';
import 'Authentications/welcome.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  chekUser(){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user =auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3),(){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }else{
      Timer(Duration(seconds: 3),(){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => welcomeScreen()));
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chekUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.webp"),
          const SizedBox(height: 30,),
          SpinKitFadingCircle(
            size: 50,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        ],),
    );
  }
}
