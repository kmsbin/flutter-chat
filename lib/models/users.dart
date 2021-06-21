import 'dart:convert';

class User {
  final String username;
  final String id;

  const User({this.username = "", this.id = ""});

  factory User.fromJson(Map<String, dynamic> rawUser) {
    return User(username: rawUser["username"], id: rawUser["id"]);
  }
  String toJson() => json.encode({"username": this.username, "id": this.id});
}

class Users {
  final List<User> users;

  const Users(this.users);

  factory Users.fromJson(Map<String, dynamic> rawUsers) {
    List<User> users = [];
    rawUsers["clients"].forEach((client) => users.add(User.fromJson(client)));
    return Users(users);
  }
}
