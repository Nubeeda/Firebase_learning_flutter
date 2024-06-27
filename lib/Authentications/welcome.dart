import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/signup.dart';

import 'login.dart';


class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.webp"),
            const SizedBox(height: 30,),
           InkWell(
             onTap: (){
               Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                       builder: (context)=>LoginScreen()));
             },
             child: Container(
               height:60 ,
               width: double.infinity,
              decoration: BoxDecoration(
                color:const Color(0xff48CEBE),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:const Row(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                Icon(Icons.person,color: Color(0xffD9D9D9),),
                  SizedBox(width: 20,),
                  Text( "Login",style: TextStyle(color: Color(0xffFFFFFF),
                      fontSize: 20,fontWeight: FontWeight.w600),)
              ],),
             ),
           ),

            const SizedBox(height: 10,),
            InkWell(
          onTap: () {
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SignupScreen()));
          },
      child:Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff48CEBE),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, color: Color(0xffD9D9D9),),
            SizedBox(width: 20,),
            Text("SignUp", style: TextStyle(color: Color(0xffFFFFFF),
                fontSize: 20, fontWeight: FontWeight.w600),)
          ],),
      ),
    ),


          ],),
      ),
    );
  }
}
