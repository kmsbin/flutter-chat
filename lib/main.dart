import 'package:flutter/material.dart';
import 'package:flutter_chat/controllers/user_chat.dart';
import 'package:flutter_chat/list_users.dart';
import 'package:get/get.dart';

void main() {
  Get.put<UserChatController>(UserChatController());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter chat',
    theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white54),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54, width: 1.0),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.normal, fontFamily: 'Roboto'),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    home: AllUsersScreen(),
  ));
}
