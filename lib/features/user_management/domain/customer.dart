import 'package:equatable/equatable.dart';
import 'package:isp_app/features/user_management/domain/types.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class Customer extends Equatable {
  final String id;
  final AuthUser user;
  final String noInternet;
  final InternetStatus status;
  final InternetData internetData;
  final String noVa;

  const Customer({
    required this.id,
    required this.user,
    required this.noInternet,
    this.status = InternetStatus.online,
    required this.internetData,
    required this.noVa,
  });

  factory Customer.fromMap(
    Map<String, dynamic> data,
  ) {
    return Customer(
      id: data['id'],
      user: AuthUser.fromMap(data),
      noInternet: data['noInternet'],
      status: InternetStatus.values
          .firstWhere((element) => element.name == data['status']),
      noVa: data['noVa'],
      internetData: InternetData.fromMap(data['internetData']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'noInternet': noInternet,
      'status': status,
      'noVa': noVa,
      'internetData': internetData.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        user,
        noInternet,
        status,
        noVa,
        internetData,
      ];
}

class InternetData extends Equatable {
  final String packageId;
  final List<String> addons;

  InternetData({required this.packageId, required this.addons});

  factory InternetData.fromMap(
    Map<String, dynamic> data,
  ) {
    return InternetData(addons: data['addons'], packageId: data['packageId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'packageId': packageId,
      'addons': addons,
    };
  }

  @override
  List<Object?> get props => [packageId, addons];
}
