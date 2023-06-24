import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Users {
  final String name;
  final String id;
  final String email;
  final String type;
  final String address;
  final String token;
  final String password;

  Users(
    this.name,
    this.id,
    this.email,
    this.type,
    this.address,
    this.token,
    this.password,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'type': type,
      'address': address,
      'token': token,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      map['name'] as String,
      map['_id'] as String,
      map['email'] as String,
      map['type'] as String,
      map['address'] as String,
      map['token'] as String,
      map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);
}
