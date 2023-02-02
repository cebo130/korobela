

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:korobela/screens/chat_screen.dart';
import 'package:korobela/widgets/chat/priv_chat.dart';


class Dummy extends StatefulWidget {
  /*Dummy(this.email, this.username, this.image_url,{this.key});
  final String email;
  final String image_url;
  final String username;
  //final bool isMe;
  final Key? key;*/

  @override
  State<Dummy> createState() => _DummyState(/*email,image_url,username,key: key*/);
}

class _DummyState extends State<Dummy> {
  /*_DummyState(this.email, this.username, this.image_url,{this.key});
  final String email;
  final String image_url;
  final String username;
  //final bool isMe;
  final Key? key;*/
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  Widget _card() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 5, left: 8, right: 8),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white60,
      ),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/1177/1177568.png"),
            ),
          ),
          title: Text(
            '',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.deepPurple),
          ),
          subtitle: Text(
            'Freedom Fighter',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
          trailing: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: StreamBuilder(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      SizedBox(height: 3,),
                      FirebaseAuth.instance.currentUser?.uid!=snapshot.data!.docChanges[index].doc['userId'] ? Container(
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white60, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 31,
                                backgroundColor: Colors.green,
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docChanges[index].doc['image_url']),
                                ),
                              ),
                              SizedBox(width: 20,),
                               Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(snapshot.data!.docChanges[index].doc['username'],style: TextStyle(color: Colors.pink,fontSize: 15,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text(snapshot.data!.docChanges[index].doc['email'],style: TextStyle(color: Colors.teal,fontSize: 10,fontWeight: FontWeight.bold),),
                                  //Text(snapshot.data!.docChanges[index].doc['email']),
                                ],
                              ),
                            ],
                          ),
                          onPressed: (){
                            print('u just clicked on ************');
                            print(snapshot.data!.docChanges[index].doc['email']);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PrivChat(snapshot.data!.docChanges[index].doc['email'],
                                snapshot.data!.docChanges[index].doc['image_url'],
                                snapshot.data!.docChanges[index].doc['username'],
                                snapshot.data!.docChanges[index].doc['userId'],)));
                            //,chatDocs[index]['userId'] == us?.uid,key: ValueKey(chatDocs[index])
                          },
                        ),
                      ) : SizedBox.shrink(),
                    ],
                  );
                },
              ),
            );
          },
        ),
    );
    /*GestureDetector(child: _card(), onTap: () {
      //start
      getData();
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ChatScreen(),),
      );*/
      //end
    });*/
  }
}

