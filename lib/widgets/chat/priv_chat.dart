import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/Home.dart';
import 'messages.dart';

class PrivChat extends StatefulWidget {
  PrivChat(this.email,this.image,this.username,this.otherId);
  final String email;
  final String image;
  final String username;
  final String otherId;
  @override
  State<PrivChat> createState() => _PrivChatState(email,image,username,otherId);
}

class _PrivChatState extends State<PrivChat> {
  _PrivChatState(this.email,this.image,this.username,this.otherId);
  final String email;
  final String image;
  final String username;
  final String otherId;

  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  var enteredMessage = '';
  //int id = 0;
  TextEditingController con = new TextEditingController();
  void sendMessages()async{
    //id++;

  }
  bool isMe = false;
  final us = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    //****************Start Here   ****//
    String myId = FirebaseAuth.instance.currentUser!.uid;
    String  oId = otherId;

    String combined = myId + oId;

    int countOC = 0;
    int countNO = 0;

    List<String?> newId = [];
    for(int i=0; i<combined.length; i++){

      newId.add(combined[i]);
    }
    //print(newId);
    //print("Sorting...");
    newId.sort();
    //print(newId);
    //print("structuring...");
    for(int i=0; i<combined.length; i++){
      //print(id2[i]);
      for(int j=i+1; j<combined.length; j++){
        if(newId[i]==newId[j]){
          countOC++;
        }else{
          countNO++;
        }
      }
    }
    String? start = newId[countOC];
    String? end = newId[newId.length -1];
    String? s = "$start$countOC$countNO$end";
    //print(s);
    //**************End here

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1), // Set this height
        child: AppBar(
          title: Text(''),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.black, Colors.pink, Colors.black]),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            customAppBar(),
            /*Expanded(child: Messages()),
            NewMessage()*/
        Expanded(
         child: FutureBuilder(
            future: Future.value(us),//FirebaseAuth.instance.currentUser,
      builder: (ctx, futureSnapshot) {
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('$s').orderBy('createAt',descending: true).snapshots(),
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
                    itemBuilder: (ctx, index) =>
                        Column(
                          children: [
                            SizedBox(height: 28,),
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: chatDocs[index]['userId']==us?.uid ? MainAxisAlignment.end : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 140,
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: chatDocs[index]['userId']==us?.uid ? Colors.pink : Colors.grey,//Theme.of(context).accentColor,
                                          borderRadius: BorderRadius.only(
                                            topRight: chatDocs[index]['userId']==us?.uid ? Radius.circular(30) : Radius.circular(30),
                                            topLeft: chatDocs[index]['userId']==us?.uid ? Radius.circular(30) : Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                        chatDocs[index]['userId']==us?.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chatDocs[index]['userId']==us?.uid ? '' : username,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: chatDocs[index]['userId']==us?.uid
                                                    ? Colors.black
                                                    : Theme.of(context).accentTextTheme.titleMedium?.color),
                                          ),
                                          Text(
                                            chatDocs[index]['text'],
                                            style: TextStyle(
                                                color: chatDocs[index]['userId']==us?.uid
                                                    ? Colors.black
                                                    : Theme.of(context).accentTextTheme.titleMedium?.color),
                                            textAlign: chatDocs[index]['userId']==us?.uid ? TextAlign.end : TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -16,
                                  left: chatDocs[index]['userId']==us?.uid ? null : 2,
                                  right: chatDocs[index]['userId']==us?.uid ? 2 : null,
                                  child: chatDocs[index]['userId']==us?.uid ? SizedBox.shrink() : CircleAvatar(
                                    backgroundImage: NetworkImage(chatDocs[index]['userImage']),
                                  ),
                                ),
                              ],
                              clipBehavior: Clip.none,
                            ),
                          ],
                        ),/*message end*/
                  ),
                );//MessageBuble(chatDocs[index]['text'],chatDocs[index]['username'],chatDocs[index]['userImage'],chatDocs[index]['userId'] == us?.uid,key: ValueKey(chatDocs[index]),),
              }
          );
      },
    ),
       ),
        Container(//*****New message start here
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
                      onPressed: enteredMessage.trim().isEmpty ? null : () async {
                        //id++;
                        FocusScope.of(context).unfocus();
                        final user = await FirebaseAuth.instance.currentUser;
                        final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                        FirebaseFirestore.instance.collection('$s').add({
                          'text': enteredMessage,
                          'createAt': Timestamp.now(),
                          //'id': id,
                          'userId': user?.uid,
                          'username': userData['username'],
                          'userImage':userData['image_url'],
                        });
                        con.clear();

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
          /**ends here ****/),
          ],
        ),
      ),
    );
  }
  Widget customAppBar(){
    return  Container(
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // background
          onPrimary: Colors.white, // foreground
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            //SizedBox(width: 20,),
            Spacer(),
            CircleAvatar(radius: 25,backgroundImage: NetworkImage('$image'),),
            SizedBox(width: 10,),
            Container(
              width: 100,
              child: Text(
                '$username',
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            //SizedBox(width: 20,),
            Spacer(),
            DropdownButton(
              underline: Container(),
              icon: Icon(Icons.more_vert,color: Colors.white,/*Theme.of(context).primaryIconTheme.color,*/),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app,color: Colors.white,),
                        SizedBox(width: 8,),
                        Text('Get out'),
                      ],
                    ),
                  ),
                  value: 'getout',
                ),
              ],
              onChanged: (Object? value) {
                if(value=='getout'){
                  //FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        onPressed: (){},
      ),
    );/*****cutom sapp bar ends****/
  }
}
