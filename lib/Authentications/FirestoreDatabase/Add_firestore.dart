import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/FirestoreDatabase/Firestore_list.dart';
import 'package:foodplanets/Authentications/login.dart';
import 'package:foodplanets/components/Round_button.dart';
import 'package:foodplanets/components/utils.dart';

class Add_firestore extends StatefulWidget {
  const Add_firestore({super.key});

  @override
  State<Add_firestore> createState() => Add_firestoreState();
}

class Add_firestoreState extends State<Add_firestore> {
  bool loading = false;

  final Addfirestore = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Add Firestore",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      backgroundColor: Colors.blueGrey.withOpacity(0.3),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              maxLines: 6,
              controller: Addfirestore,
              onTap: () {},
              decoration: InputDecoration(
                hintText: "What's your mind?",
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: loading,
                title: "FireStore List view",
                onTap: () {
                  setState(() {
                    loading = false;
                  });

                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    "title": Addfirestore.text.toString(),
                    "id": id,
                  }).then((value) {
                    setState(() {
                      loading = false;

                    });
                    Utils().toastMessage("Data Added Successfully");
                    Addfirestore.text = "";

                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());

                    setState(() {
                      loading = false;
                    });
                  });
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FireStore_listScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
