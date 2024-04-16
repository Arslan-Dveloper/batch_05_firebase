import 'package:get_storage_pro/get_storage_pro.dart';

class UserModal {
  String? name;
  String? email;
  String? password;

  String? id;

  UserModal({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      id: map['id'] as dynamic,
    );
  }
}
