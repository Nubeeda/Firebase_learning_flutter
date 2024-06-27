
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/Authentications/login.dart';
import 'package:foodplanets/components/utils.dart';

import 'addposts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController updatecontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Color(0xff256860),
        title: Text(
          "Posts Screen",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          //       if(!snapshot.hasData){
          //         return const CircularProgressIndicator();
          //       }else{
          //
          //         Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //
          //         List<dynamic> list = [];
          //         list.clear();
          //         list = map.values.toList();
          //
          //
          //         return ListView.builder(
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (context, index){
          //               return ListTile(
          //                 title: Text(list[index]['title']),
          //                 subtitle: Text(list[index]['id']),
          //               );
          //             });
          //       }
          //
          //     },
          //   ),
          // ),
          // Divider(),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: searchcontroller,
              decoration: InputDecoration(
                  hintText: "Search", border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Center(
                    child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child("title").value.toString();
                  if (searchcontroller.text.isEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        textColor: Color(0xff9575CD),
                        subtitleTextStyle: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.greenAccent,
                        ),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showMyDialog(
                                              title, snapshot.child("id").value.toString());
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text("Edit"),
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: () {
                                          ref.child(snapshot.child("id").value.toString()).remove();
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      )),
                                ]),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchcontroller.text.toString())) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostsScreen()));
        },
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    updatecontroller.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: Border(),
            title: Text("Update"),
            content: TextField(
              controller: updatecontroller,
              decoration: InputDecoration(hintText: "Update Your text"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      "title" : updatecontroller.text.toString(),
                    }).then((value) {
                      Utils().toastMessage("Your Updated Successfully");
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }
}
