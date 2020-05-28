import 'package:flutter/material.dart';
import 'package:flutter_chat/screen/auth_data.dart';
import './screen/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx,userSnapShot){
          if(userSnapShot.hasData){
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
