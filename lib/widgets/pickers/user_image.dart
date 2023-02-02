import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  UserImage(this.imagePickFn);
  final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  var pickedPic;
  void _pickImage() async {
    //ImagePicker.pickImage(source: ImageSource.gallery);
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source:ImageSource.gallery,imageQuality: 50,maxWidth: 150);//getImage(...);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      pickedPic = pickedImageFile;
    });
    widget.imagePickFn(pickedPic);
  }


  /*Future pickImage()async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    /*setState(() {
      pickedPic = pickedImageFile as File;
    });*/
    return pickedImageFile;
  }*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*CircleAvatar(
            radius: 50,
            backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,
          backgroundColor: Colors.grey,
        ),*/
        pickedPic != null ? GestureDetector(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: pickedPic != null ? FileImage(pickedPic) : null,
            backgroundColor: Colors.grey,
          ),
          onTap: (){_pickImage();},
        ):
         GestureDetector(child: Image.network('https://cdn-icons-png.flaticon.com/512/1177/1177568.png',scale: 7,),onTap: (){_pickImage();},),
        //FlatButton.icon(onPressed: (){_pickImage();}, icon: Icon(Icons.image), label:Text('add pic'),textColor: Theme.of(context).primaryColor,),
        Container(
          width: 110,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            child: Row(
              children: [
                Icon(Icons.image,/*color: Colors.teal*/),
                Text('add pic',/*style: TextStyle(color: Colors.teal),*/),
              ],
            ),
            onPressed: (){_pickImage();},
          ),
        )
      ],
    );
  }
}
