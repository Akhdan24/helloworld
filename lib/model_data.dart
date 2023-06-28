import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String? id;
  final String? name;

  UserData({this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static UserData fromJson(Map<String, dynamic> json) =>
      UserData(id: json['id'], name: 'name');
}
