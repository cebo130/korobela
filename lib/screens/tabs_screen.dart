import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:korobela/screens/chat_home.dart';
import 'package:korobela/screens/chat_screen.dart';
import 'package:korobela/socialise/home_page.dart';
import 'package:korobela/widgets/chat/users.dart';
import 'package:korobela/widgets/dummy.dart';

import '../widgets/menu_widget.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Text('Slide',style: TextStyle(color: Colors.cyanAccent),),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.pink,
                        Colors.black,
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft//where to begin
                  )
              ),
            ),
            elevation: 10,  //shadow
            titleSpacing: 10,  //space between leading icon and title
            leading: MenuWidget(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none,color: Colors.cyanAccent,),),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search,color: Colors.cyanAccent,),)
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.group,color: Colors.cyanAccent,),child: Text('People',style: TextStyle(color: Colors.cyanAccent),),),
                Tab(icon: Icon(Icons.chat_bubble,color: Colors.cyanAccent,),child: Text("DM's",style: TextStyle(color: Colors.cyanAccent),),),
                Tab(icon: Icon(Icons.interests,color: Colors.cyanAccent,),child: Text('Socialise',style: TextStyle(color: Colors.cyanAccent),),),
              ],
              indicator: ShapeDecoration(
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.cyanAccent,
                          width: 4.0,
                          style: BorderStyle.solid)),
                  /*gradient: LinearGradient(colors:),*/),
            ),
          ),
          body: TabBarView(
            children: [
              //ChatHome(),
             /*SingleChildScrollView(
                child: Column(
                  children: [
                    Dummy(),
                  ],
                ),
              ),*/
             Dummy(),
              ChatScreen(),
          SingleChildScrollView(
            child: Column(
              children: [
              SizedBox(height: 3,),
            Container(
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
                            'https://image.shutterstock.com/image-vector/wheel-fortune-lottery-luck-illustration-600w-614617094.jpg'),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text('Spin the wheel',style: TextStyle(color: Colors.pink,fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text('match makaking time !',style: TextStyle(color: Colors.teal,fontSize: 10,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                onPressed: (){
                  //print('u just clicked on ************');
                 // print(snapshot.data!.docChanges[index].doc['email']);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
