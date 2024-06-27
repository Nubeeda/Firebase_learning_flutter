import 'package:flutter/material.dart';


class UIhelper{
  static customAlertBox(BuildContext context,String text){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(text,textAlign: TextAlign.center,style: TextStyle(
              fontSize: 14.0,
            ),),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
          );

        });

  }
  static customButton(VoidCallback callback,String text){
    return SizedBox(
    width: 300,
     height: 50,
     child: ElevatedButton(
       style: ElevatedButton.styleFrom(
         backgroundColor: Color(0xff48CEBE),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
         )
       ),onPressed: (){
         callback();
        },
       child: Text(text,style: TextStyle(color: Colors.white),),
     ),
    );
  }
  static customTextFormField({required TextEditingController controller, required String text, required IconData iconData, required bool toHide}){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0)
            )
        ),
      ),
    );

  }
}