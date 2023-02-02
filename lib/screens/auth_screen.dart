//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korobela/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,File? image ,bool isLogin,BuildContext ctx) async {
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      });
    if (isLogin) {
      authResult =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } else {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');
      await ref.putFile(image!).whenComplete(() => print('Uploading Image Done'));
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
        'username': username,
        'email': email,
        'image_url': url,
        'userId': authResult.user?.uid,
      });
    }
  } on PlatformException catch(e){
      String? message = 'an error occured, please check your credentials bro...';
      if(e.message != null){
        message = e.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message!),backgroundColor: Theme.of(context).errorColor,));
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      print(e);
      _isLoading = false;
      String err = e.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(err),backgroundColor: Theme.of(context).errorColor,));
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.centerRight,
      //         colors: [Colors.orange,Colors.red, Colors.green,])),
      color: Colors.black,
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.black,
        body: AuthForm(_submitAuthForm,_isLoading),
      ),
    );
  }
}
