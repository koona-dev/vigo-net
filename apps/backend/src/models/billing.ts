export default class Billing {
  orderId: string;
  grossAmount: number;
  firstName: string;
  lastName: string;
  email: string;
  phone: string;
  paymentType: string;
  bank: string;
  vaBank: string;

  constructor(data: {
    orderId: string;
    grossAmount: number;
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
    paymentType: string;
    bank: string;
    vaBank: string;
  }) {
    this.orderId = data.orderId;
    this.grossAmount = data.grossAmount;
    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.email = data.email;
    this.phone = data.phone;
    this.paymentType = data.paymentType;
    this.bank = data.bank;
    this.vaBank = data.vaBank;
  }

  static fromMap(json: { [field: string]: any }) {
    return new Billing({
      orderId: json.orderId,
      grossAmount: json.grossAmount,
      firstName: json.firstName,
      lastName: json.lastName,
      email: json.email,
      phone: json.phone,
      paymentType: json.paymentType,
      bank: json.bank,
      vaBank: json.vaBank,
    });
  }
}
