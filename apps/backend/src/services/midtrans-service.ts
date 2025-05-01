import Billing from "../models/billing";

import midtransSnap from "../config/midtrans-config";
export default class MidtransService {
  async createVA(billing: Billing): Promise<{ [field: string]: any }> {
    let parameter = {
      transaction_details: {
        order_id: billing.orderId,
        gross_amount: billing.grossAmount, // Amount in IDR
      },
      customer_details: {
        first_name: billing.firstName,
        last_name: billing.lastName,
        email: billing.email,
        phone: billing.phone,
      },
      payment_type: billing.paymentType,
      bank_transfer: {
        bank: billing.bank,
        va_number: billing.vaBank, // Replace with the actual VA number
      },
    };

    try {
      // return {
      //   va_number: transaction.va_numbers[0].va_number,
      //   bank: transaction.va_numbers[0].bank,
      // };
      return await midtransSnap.createTransactionRedirectUrl(parameter);
    } catch (error: any) {
      throw error;
    }
  }

  async checkPaymentStatus(orderId: string): Promise<{ [field: string]: any }> {
    try {
      return await midtransSnap.transaction.status(orderId);
    } catch (error: any) {
      throw error;
    }
  }
}
