import 'package:dio/dio.dart';

class IdGenerator {
  static Future<String> get() async {
    final dio = Dio();
    Response resp = await dio.get('https://golchat.herokuapp.com/enter-room');

    return resp.data['key'];
  }
}
