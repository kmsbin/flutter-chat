import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/chat.dart';
import 'package:flutter_chat/controllers/user_chat.dart';
import 'package:flutter_chat/resources/id_generator.dart';
import 'package:flutter_chat/utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_chat/controllers/list_users.dart';
import 'package:get/get.dart';

class AllUsersScreen extends StatelessWidget {
  final UsersController _listUsers = UsersController();

  @override
  Widget build(BuildContext context) {
    _listUsers.getUsers();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => dialog(context));
    // showDialog(context: context, builder: (context) => dialog(context));

    return Scaffold(
      body: Observer(builder: (ctxt) {
        return ListView.builder(
          itemCount: _listUsers.getUsersCount,
          itemBuilder: (ctxt, index) {
            final users = _listUsers.listUsers.users;

            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatHub(users[index])),
                );
              },
              title: Text(users[index].username),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialog(context);
        },
        child: Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}

dialog(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  final TextEditingController _modalController = TextEditingController();
  print("largura:  ${screenSize.width * 0.75}");

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctxt) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Container(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 350,
              height: 210,
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(),
                  Container(
                      child: TextFormField(
                    controller: _modalController,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (evt) {},
                    style: TextStyle(
                      color: Colors.white54,
                      decorationColor: Colors.white54,
                    ),
                  )),
                  ElevatedButton(
                      onPressed: () async {
                        var userChatController = Get.find<UserChatController>();
                        var uri = Utils.wsConnectionUriBuilder(name: _modalController.text, id: await IdGenerator.get());
                        userChatController.connectAndListen(uri);
                        Navigator.pop(ctxt);
                        // print(await IdGenerator.get());
                      },
                      child: Text("Enter room"))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
