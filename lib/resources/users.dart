import 'package:dio/dio.dart';
import 'package:flutter_chat/models/users.dart';

class UsersConnect {
  static Future<Users> get() async {
    final dio = Dio();
    Response resp = await dio.get('https://golchat.herokuapp.com/getAllUsers');

    return Users.fromJson(resp.data);
  }
}
