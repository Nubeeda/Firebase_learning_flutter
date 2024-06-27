

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/signup.dart';
import 'package:foodplanets/components/utils.dart';

class FireStore_listScreen extends StatefulWidget {
  const FireStore_listScreen({super.key});

  @override
  State<FireStore_listScreen> createState() => _FireStore_listScreenState();
}

class _FireStore_listScreenState extends State<FireStore_listScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final updatecontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("users").snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          "Fire store screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Some Error message");
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data!.docs[index]["title"].toString()),
                          subtitle:
                              Text(snapshot.data!.docs[index]["id"].toString()),
                          trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                        value: 1,
                                        child: ListTile(
                                          onTap: () {
                                            showMyDialog(
                                                snapshot
                                                    .data!.docs[index]["title"]
                                                    .toString(),
                                                snapshot.data!.docs[index]["id"]
                                                    .toString());
                                          },
                                          leading: const Icon(Icons.edit),
                                          title: const Text("Update"),
                                        )),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: () {
                                          ref
                                              .doc(snapshot
                                                  .data!.docs[index]["id"]
                                                  .toString())
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      ),
                                    ),
                                  ]),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }

   Future <void> showMyDialog(String title, String id) async {
    updatecontroller.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            shape: Border(),
            content: TextField(
              controller: updatecontroller,
              decoration: InputDecoration(hintText: 'Update your Text'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  ref.doc("id").update({
                    "title": updatecontroller.text.toString(),
                  }).then((value) {
                    Utils().toastMessage("Data update successful");
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text("Update"),
              )
            ],
          );
        });
  }
}
