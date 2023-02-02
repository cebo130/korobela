import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  MessageBuble(this.message, this.username, this.userImage, this.isMe,{this.key});
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key? key;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18,),
        Stack(
          children: [

        Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                  color: isMe ? Colors.pink : Colors.grey,//Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: isMe ? Radius.circular(30) : Radius.circular(30),
                    topLeft: isMe ? Radius.circular(30) : Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [

                  /*FutureBuilder<Object>(
                    future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Text('Loading...');
                      }
                      if(snapshot.data == null){
                        return Text(
                          'No data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      }else{
                        return Text(
                          snapshot.data['username'],
                          style: TextStyle(fontWeight: FontWeight.bold, color: isMe
                              ? Colors.black
                              : Theme.of(context).accentTextTheme.titleMedium?.color),
                        );
                      }// or just use if (snapshot.hasData)
                    },

                  ),*/
                  Text(
                    isMe ? '' : username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.titleMedium?.color),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.titleMedium?.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
            Positioned(
              top: -16,
              left: isMe ? null : 2,
              right: isMe ? 2 : null,
              child: isMe ? SizedBox.shrink() : CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ],
    );
  }
}
