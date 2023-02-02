import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:korobela/screens/auth_screen.dart';
import 'package:korobela/screens/chat_screen.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  //start
  String name = '';
  String username1 = '';
  DocumentReference userName = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);


  @override
  void initState() {
    super.initState();
    userName.get().then((DocumentSnapshot ds) {
      username1 = ds['username'];
      //print(username1);

    });
  }
  String myId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context){
    //Get specific field from a document
    /*userName.get().then((DocumentSnapshot ds) {
      username1 = ds['username'];
      print(username1);
      name = ds['email'];
      print(name);
    });*/



    return FutureBuilder<DocumentSnapshot>(
      future: userName.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
               CircleAvatar(radius: 60,backgroundImage: NetworkImage('${data['image_url']}'),),
                SizedBox(height: 20,),
               // Text(myId,style: TextStyle(color: Colors.white,fontSize: 30),),
                SizedBox(height: 20,),
                Text('${data['username']} ',style: TextStyle(color: Colors.white,fontSize: 30),),
                Divider(color: Colors.tealAccent,thickness: 1.5,),
                /*Divider(color: Colors.tealAccent,thickness: 2,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text('14 crush',style: TextStyle(color: Colors.tealAccent,fontSize: 25),),
                    SizedBox(width: 10,),
                    Text('|',style: TextStyle(color: Colors.tealAccent),),
                    SizedBox(width: 10,),
                    Text('2 shots',style: TextStyle(color: Colors.tealAccent),),
                    SizedBox(width: 10,),
                    Text('|',style: TextStyle(color: Colors.tealAccent),),
                    SizedBox(width: 10,),
                    Text('3 slides',style: TextStyle(color: Colors.tealAccent),),
                  ],
                ),
                Divider(color: Colors.tealAccent,thickness: 2,),*/
                SizedBox(height: 7,),
                ListTile(
                  leading: Icon(Icons.person,color: Colors.tealAccent,size: 30,),
                  title: Text('My Profile',style: TextStyle(color: Colors.tealAccent,fontSize: 20),),
                  onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen())),
                ),
                SizedBox(height: 7,),
                ListTile(
                  leading: Icon(Icons.settings,color: Colors.tealAccent,size: 30,),
                  title: Text('Settings',style: TextStyle(color: Colors.tealAccent,fontSize: 20),),
                  onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen())),
                ),
                SizedBox(height: 7,),
                ListTile(
                  leading: Icon(Icons.chat_bubble,color: Colors.tealAccent,size: 30,),
                  title: Text('Chat',style: TextStyle(color: Colors.tealAccent,fontSize: 20),),
                  onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen())),
                ),
                SizedBox(height: 7,),
                ListTile(
                  leading: Icon(Icons.star,color: Colors.tealAccent,size: 30,),
                  title: Text('Rate me',style: TextStyle(color: Colors.tealAccent,fontSize: 20),),
                  onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen())),
                ),
                SizedBox(height: 7,),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.tealAccent,size: 30,),
                  title: Text('Logout',style: TextStyle(color: Colors.tealAccent,fontSize: 20),),
                  onTap: ()=>
                  {
                  FirebaseAuth.instance.signOut(),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen())),
                  }
                  ,
                ),
              ],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}

