import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './msg_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, futureSnapShot) {
              if (futureSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return  StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = chatSnapShot.data.documents;
        return ListView.builder(
                reverse: true,
                itemCount: chatDoc.length,
                itemBuilder: (ctx, index) => MsgBuble(
                  chatDoc[index]['text'],
                  chatDoc[index]['userId'],
                  chatDoc[index]['userId'] == futureSnapShot.data.uid,
                  key: ValueKey(chatDoc[index].documentID),
                ),
              );
            });
      },
    );
  }
}
