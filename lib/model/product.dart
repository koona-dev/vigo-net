import 'package:equatable/equatable.dart';

class Catalog {
  final List<Internet> internetData;
  final List<Addons> addonsData;

  Catalog({
    required this.internetData,
    required this.addonsData,
  });
}

class Internet extends Equatable {
  final String? id;
  final String? title;
  final String? deskripsi;
  final int? price;
  final int? kuota;
  final String? role;
  final String? wilayah;

  const Internet({
    this.id,
    this.title,
    this.deskripsi,
    this.price,
    this.kuota,
    this.role,
    this.wilayah,
  });

  factory Internet.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Internet(
      id: id,
      title: data['title'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      price: data['price'] ?? 0,
      wilayah: data['wilayah'] ?? '',
      role: data['role'] ?? '',
      kuota: data['kuota'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        deskripsi,
        price,
        wilayah,
        role,
        kuota,
      ];
}

class Addons extends Equatable {
  final String? id;
  final String? title;
  final String? deskripsi;
  final int? price;

  const Addons({
    this.id,
    this.title,
    this.deskripsi,
    this.price,
  });

  factory Addons.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Addons(
      id: id,
      title: data['title'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      price: data['price'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        deskripsi,
        price,
      ];
}
