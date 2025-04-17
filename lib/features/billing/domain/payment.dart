import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String? id;
  final String customerId;
  final PaymentType paymentType;
  final VaBank vaBank;
  final String? activeVaBank;

  const Payment({
    this.id,
    required this.customerId,
    required this.paymentType,
    required this.vaBank,
    this.activeVaBank,
  });

  factory Payment.fromMap(
    Map<String, dynamic> data,
  ) {
    return Payment(
      id: data['id'],
      customerId: data['customerId'],
      paymentType: PaymentType.values
          .firstWhere((element) => element.name == data['paymentType']),
      vaBank: VaBank.fromMap(data['vaBank']),
      activeVaBank: data['activeVaBank'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'paymentType': paymentType.name,
      'vaBank': vaBank.toMap(),
      'activeVaBank': activeVaBank,
    };
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        paymentType,
        vaBank,
        activeVaBank,
      ];
}

class VaBank {
  final int bca;
  final int bni;
  final int mandiri;
  final int bri;

  const VaBank({
    required this.bca,
    required this.bni,
    required this.mandiri,
    required this.bri,
  });

  factory VaBank.fromMap(
    Map<String, dynamic> data,
  ) {
    return VaBank(
      bca: data['bca'],
      bni: data['bni'],
      mandiri: data['mandiri'],
      bri: data['bri'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bca': bca,
      'bni': bni,
      'mandiri': mandiri,
      'bri': bri,
    };
  }
}

enum PaymentType {
  bankTransfer(
    name: "bank_transfer",
  ),
  eWallet(
    name: "e_wallet",
  ),
  virtualAccount(
    name: "virtual_account",
  ),
  creditCard(
    name: "credit_card",
  ),
  cod(
    name: "cod",
  ),
  qris(
    name: "qris",
  ),

  merchant(name: "merchant");

  final String name;
  const PaymentType({required this.name});
}
