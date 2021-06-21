import 'dart:async';
import 'dart:convert';

import 'package:flutter_chat/models/message_model.dart';
import 'package:mobx/mobx.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'user_chat.g.dart';

class UserChatController = UserChatControllerBase with _$UserChatController;

abstract class UserChatControllerBase with Store {
  @observable
  String idReciever = '0';

  @observable
  ObservableList<Message> messages = ObservableList();

  WebSocketChannel? wsChann;

  @action
  void connectAndListen(String uri) {
    wsChann = WebSocketChannel.connect(Uri.parse(uri));
    this.periodicPing();
    this.listenMessages();
  }

  @action
  void listenMessages() {
    wsChann?.stream.listen((event) {
      final RecieveMessage msg = RecieveMessage.fromString(event.toString());
      print("new Message: " + msg.value);
      addMessage(msg);
    });
  }

  @action
  addMessage(Message msg) {
    this.messages.add(msg);
  }

  void periodicPing() {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      wsChann?.sink.add('');
    });
  }

  @action
  void sendMessage({String msg = '', String idReciever = ''}) {
    String msgEncoded = json.encode({"message": msg, "id-reciever": idReciever});
    print(msgEncoded);
    messages.add(SendMessage(idReciever: idReciever, value: msg));
    wsChann?.sink.add(msgEncoded);
  }

  void close() => wsChann?.sink.close();
}
