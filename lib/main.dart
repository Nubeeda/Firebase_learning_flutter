import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodplanets/Authentications/signup.dart';
import 'Authentications/FirestoreDatabase/Add_firestore.dart';
import 'Authentications/FirestoreDatabase/Firestore_list.dart';
import 'Authentications/Otp/Otp_verification.dart';
import 'Authentications/Otp/signin_with phone.dart';
import 'Authentications/Posts/addposts.dart';
import 'Authentications/Posts/posts.dart';
import 'Authentications/home.dart';
import 'Authentications/login.dart';
import 'Authentications/password_forgot.dart';
import 'firebase_options.dart';
import 'loading.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyD60_N3BTacPxfy-wS8SEpfArRxA23c7yk",
        appId: "1:657549718965:android:cdc625a2c6e87158f0d5fc",
        messagingSenderId: "657549718965",
        projectId:"my-app-294bf",
        authDomain: "my-app-294bf.firebaseapp.com",
      databaseURL: "https://my-app-294bf-default-rtdb.firebaseio.com",
      storageBucket: "my-app-294bf.appspot.com",

    ),

  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoadingScreen(),
    );
  }

}

