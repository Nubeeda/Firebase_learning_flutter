import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodplanets/components/utils.dart';
import '../../components/Round_button.dart';
import 'package:flutter/widgets.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  TextEditingController postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff256860),
        title: Text(
          "Add Posts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              maxLines: 6,
              controller: postcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                hintText: "What is in your mind?",
              ),
            ),
            SizedBox(
              height: 50,
            ),
           RoundButton(
               title: "Add posts",
               loading: loading,
               onTap: (){
                 setState(() {
                   loading = false;
                 });
                 String id = DateTime.now().microsecondsSinceEpoch.toString();
                 databaseRef.child(id).
                 set({
                   "id":id,
                   "title":postcontroller.text.toString(),
                 }).then((value){
                   Utils().toastMessage("Post is added successfully");
                   postcontroller.text="";
                   setState(() {
                     loading=false;
                   });
                 }).onError((error, stackTrace){
                   Utils().toastMessage(error.toString());
                   setState(() {
                     loading=false;
                   });
                 });

               }),

          ],
        ),
      ),
    );
  }
}
