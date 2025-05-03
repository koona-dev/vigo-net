import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:vigo_net_mobile/features/user_management/domain/types.dart';

class AuthUser extends Equatable {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? phone;
  final String? name;
  final String? address;
  final String? noKtp;
  final List<dynamic> housePhotoUrl;
  final UserRole role;

  const AuthUser({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phone,
    this.name,
    this.address,
    this.noKtp,
    this.housePhotoUrl = const [],
    this.role = UserRole.user,
  });

  factory AuthUser.fromMap(
    Map<String, dynamic> data,
  ) {
    return AuthUser(
      id: data['id'],
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      noKtp: data['noKtp'] ?? '',
      housePhotoUrl: data['housePhotoUrl'] ?? <String>[],
      role:
          UserRole.values.firstWhere((element) => element.name == data['role']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'name': name,
      'address': address,
      'noKtp': noKtp,
      'housePhotoUrl': FieldValue.arrayUnion(housePhotoUrl),
      'role': role.name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        email,
        phone,
        name,
        role,
      ];
}
