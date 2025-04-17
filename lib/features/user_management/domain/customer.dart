import 'package:equatable/equatable.dart';
import 'package:isp_app/features/user_management/domain/types.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class Customer extends Equatable {
  final String id;
  final AuthUser user;
  final String nomorInternet;
  final InternetStatus status;
  final InternetData internetData;
  final String nomorCustomer;

  const Customer({
    required this.id,
    required this.user,
    required this.nomorInternet,
    this.status = InternetStatus.online,
    required this.internetData,
    required this.nomorCustomer,
  });

  factory Customer.fromMap(
    Map<String, dynamic> data,
  ) {
    return Customer(
      id: data['id'],
      user: AuthUser.fromMap(data),
      nomorInternet: data['nomorInternet'],
      status: InternetStatus.values
          .firstWhere((element) => element.name == data['status']),
      nomorCustomer: data['nomorCustomer'],
      internetData: InternetData.fromMap(data['internetData']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'nomorInternet': nomorInternet,
      'status': status,
      'nomorCustomer': nomorCustomer,
      'internetData': internetData.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        user,
        nomorInternet,
        status,
        nomorCustomer,
        internetData,
      ];
}

class InternetData extends Equatable {
  final String packageId;
  final List<String> addonsId;

  InternetData({required this.packageId, required this.addonsId});

  factory InternetData.fromMap(
    Map<String, dynamic> data,
  ) {
    return InternetData(
        addonsId: data['addonsId'], packageId: data['packageId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'packageId': packageId,
      'addonsId': addonsId,
    };
  }

  @override
  List<Object?> get props => [packageId, addonsId];
}
