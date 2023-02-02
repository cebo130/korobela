import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:korobela/widgets/chat/message_buble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final us = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future: Future.value(us),//FirebaseAuth.instance.currentUser,
      builder: (ctx, futureSnapshot) {
        if(futureSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
       return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createAt',descending: true).snapshots(),
      builder: (ctx,AsyncSnapshot chatSnapshot){
        if(chatSnapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        final chatDocs = chatSnapshot.data.docs!;
        return Container(
          color: Colors.white,
          child: ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBuble(chatDocs[index]['text'],chatDocs[index]['username'],chatDocs[index]['userImage'],chatDocs[index]['userId'] == us?.uid,key: ValueKey(chatDocs[index]),),
              ),
        );
          }
        );
      },
    );
  }
}
