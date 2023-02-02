import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage = '';
  //int id = 0;
  TextEditingController con = new TextEditingController();
  void sendMessages()async{
    //id++;
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    FirebaseFirestore.instance.collection('chat3').add({
      'text': enteredMessage,
      'createAt': Timestamp.now(),
      //'id': id,
      'userId': user?.uid,
      'username': userData['username'],
      'userImage':userData['image_url'],
    });
    con.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(//*****New message start here
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Row(

          children: [
            Expanded(
                child: TextField(
                  controller: con,
                  decoration: InputDecoration(labelText: 'Send a message...',border: InputBorder.none,),

                  onChanged: (value){
                    setState(() {
                      enteredMessage = value;
                      //value = '';
                    });
                  },
                )
            ),
              Container(
                width: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                child: IconButton(
                  color: Colors.tealAccent,//Theme.of(context).primaryColor,
                  icon: Icon(Icons.send),
                  onPressed: enteredMessage.trim().isEmpty ? null : (){
                    sendMessages();

                   // enteredMessage = '';
                  },
                ),
                  onPressed: (){},
            ),
              )
          ],
        ),
        onPressed: (){},
      ),
    /**ends here ****/);
  }
}
