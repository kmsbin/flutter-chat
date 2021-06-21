import 'dart:convert';

class RecieveMessage extends Message {
  final String value;
  final String idSender;

  @override
  final String idReciever;
  @override
  final String username;

  @override
  const RecieveMessage({this.username = "", this.value = "", this.idReciever = "", this.idSender = ""});

  factory RecieveMessage.fromJson(Map<String, dynamic> rawMessage) {
    return RecieveMessage(
        value: rawMessage["message"], idReciever: rawMessage["id-reciever"], idSender: rawMessage["id-sender"], username: rawMessage["username"]);
  }
  factory RecieveMessage.fromString(String stringMessage) {
    var rawMessage = json.decode(stringMessage);
    return RecieveMessage(
        value: rawMessage["message"], idReciever: rawMessage["id-reciever"], idSender: rawMessage["id-sender"], username: rawMessage["username"]);
  }
}

abstract class Message {
  final String username;
  final String idReciever;
  final String value;
  const Message({this.username = "", this.idReciever = "", this.value = ""});
}

class SendMessage extends Message {
  final String username;
  final String idReciever;
  final String value;
  const SendMessage({this.username = "", this.idReciever = "", this.value = ""});
}
