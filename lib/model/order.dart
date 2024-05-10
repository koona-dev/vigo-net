import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  String? internetId;
  List<AddonsCart> addons;
  int subTotalPrice;

  Cart({
    this.internetId,
    this.addons = const [],
    this.subTotalPrice = 0,
  });

  @override
  List<Object?> get props => [
        internetId,
        addons,
        subTotalPrice,
      ];
}

class AddonsCart extends Equatable {
  String? id;
  int qty;

  AddonsCart({this.id, this.qty = 0});

  @override
  List<Object?> get props => [id, qty];
}
