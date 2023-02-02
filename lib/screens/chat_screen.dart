import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korobela/screens/Home.dart';
import 'package:korobela/screens/tabs_screen.dart';
import 'package:korobela/widgets/chat/messages.dart';
import 'package:korobela/widgets/chat/new_message.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    final fbm = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    });
    /*
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    });
    */

    super.initState();
  }
  @override
  final _fireStore = FirebaseFirestore.instance;
  String wat = '';
  Future<void> getData() async {
    Firebase.initializeApp();
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('chats').get();

    // Get data from docs and convert map to List
    //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    final allData = querySnapshot.docs.map((doc) => doc.get('text')).toList();
    final us = FirebaseAuth.instance.currentUser;
    //String? name = us['username'];//display username and image
    print(allData.toString());
    wat = allData as String;
  }
  Widget build(BuildContext context) {

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
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance.collection('chats/oXtX5qVZ2jy6PJFThiB2/messages').add({'text':'i got in here by the click of a button'});
        },
      ),*/
    );
  }
}
