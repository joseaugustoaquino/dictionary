// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String name;
  String user;
  String password;
  
  UserModel({
    this.id,

    this.name = "",
    this.user = "",
    this.password = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,

      'name': name,
      'user': user,
      'password': password,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],

      name: map['name'] ?? "",
      user: map['user'] ?? "",
      password: map['password'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, user: $user, password: $password)';
  }
}
