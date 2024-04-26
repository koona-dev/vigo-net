import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String? id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String name;
  final String address;
  final String noKtp;
  final String housePhotoUrl;

  const AuthUser({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.name,
    this.address = '',
    this.noKtp = '',
    this.housePhotoUrl = '',
  });

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    return AuthUser(
      id: data['id'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      noKtp: data['noKtp'] ?? '',
      housePhotoUrl: data['housePhotoUrl'] ?? '',
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
      'housePhotoUrl': housePhotoUrl,
    };
  }

  @override
  List<Object?> get props => [id];
}
