import 'package:flutter_chat/models/users.dart';
import 'package:flutter_chat/resources/users.dart';
import 'package:mobx/mobx.dart';

part 'list_users.g.dart';

class UsersController = UsersControllerBase with _$UsersController;

abstract class UsersControllerBase with Store {
  @observable
  Users listUsers = Users([]);

  @action
  getUsers() async {
    listUsers = await UsersConnect.get();
  }

  @computed
  get getUsersCount => this.listUsers.users.length;
}
