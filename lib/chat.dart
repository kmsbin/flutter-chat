import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/controllers/user_chat.dart';
import 'package:flutter_chat/models/message_model.dart';
import 'package:flutter_chat/models/users.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

class ChatHub extends StatelessWidget {
  final User _user;
  final TextEditingController txtController = TextEditingController();
  ChatHub(this._user);
  final UserChatController userController = Get.find<UserChatController>();

  @override
  Widget build(BuildContext context) {
    // final stream = userController.wsChann!.stream;
    // userController.listenMessages();
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          title: Text(_user.username),
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              Expanded(
                child: Observer(
                  builder: (context) {
                    return ListView.builder(
                        itemCount: userController.messages.length,
                        itemBuilder: (ctxt, index) {
                          Message msg = userController.messages[index];
                          return Container(
                              alignment: msg is SendMessage ? Alignment.centerRight : Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(right: msg is SendMessage ? 0 : 30, top: 4, bottom: 4, left: msg is SendMessage ? 30 : 0),
                                decoration: BoxDecoration(
                                    color: msg is SendMessage ? Color(0xff94D0CC) : Color(0xffFBC6A4),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: msg is SendMessage ? Color(0xff94D0CC) : Color(0xffFBC6A4),
                                      width: 1,
                                    )),
                                child: Text(
                                  userController.messages[index].value,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ));
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                        child: TextFormField(
                      controller: txtController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (evt) {},
                      style: TextStyle(
                        color: Colors.white54,
                        decorationColor: Colors.white54,
                      ),
                      // The validator receives the text that the user has entered.
                    )),
                    IconButton(
                        onPressed: () {
                          userController.sendMessage(msg: txtController.text, idReciever: _user.id);
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
