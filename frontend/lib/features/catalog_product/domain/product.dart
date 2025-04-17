import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product {
  final List<Internet> internetData;
  final List<Addons> addonsData;

  Product({
    required this.internetData,
    required this.addonsData,
  });
}

class Internet extends Equatable {
  final String? id;
  final String title;
  final String deskripsi;
  final String kategori;
  final int price;
  final int kuota;
  final String instansi;
  final String wilayah;
  final Timestamp expired;

  const Internet({
    this.id,
    required this.title,
    required this.kategori,
    required this.expired,
    required this.deskripsi,
    required this.price,
    required this.kuota,
    required this.instansi,
    required this.wilayah,
  });

  factory Internet.fromMap(Map<String, dynamic> data) {
    return Internet(
      id: data['id'] ?? '',
      title: data['title'],
      deskripsi: data['deskripsi'],
      price: data['price'],
      wilayah: data['wilayah'],
      instansi: data['instansi'],
      kuota: data['kuota'],
      kategori: data['kategori'],
      expired: data['expired'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        kategori,
        expired,
        deskripsi,
        price,
        wilayah,
        instansi,
        kuota,
      ];
}

class Addons extends Equatable {
  final String? id;
  final String title;
  final String kategori;
  final String deskripsi;
  final int price;

  const Addons({
    this.id,
    required this.title,
    required this.kategori,
    required this.deskripsi,
    required this.price,
  });

  factory Addons.fromMap(Map<String, dynamic> data) {
    return Addons(
      id: data['id'] ?? '',
      title: data['title'],
      deskripsi: data['deskripsi'],
      kategori: data['kategori'],
      price: data['price'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        deskripsi,
        kategori,
        price,
      ];
}
