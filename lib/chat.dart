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
        body: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (context) {
                  return ListView.builder(
                      itemCount: userController.messages.length,
                      itemBuilder: (ctxt, index) {
                        Message msg = userController.messages[index];
                        if (msg is RecieveMessage) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Text(userController.messages[index].value),
                          );
                        } else if (msg is SendMessage) {
                          return Container(
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Text(userController.messages[index].value),
                          );
                        }
                        return Text('');
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
                      color: const Color(0xffd31b77),
                      decorationColor: const Color(0xffd31b77),
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
        ));
  }
}
