import Billing from "../models/billing";

import midtransSnap from "../config/midtrans-config";
export default class MidtransService {
  async createVA(parameter: {
    [field: string]: any;
  }): Promise<{ [field: string]: any }> {
    try {
      // return {
      //   va_number: transaction.va_numbers[0].va_number,
      //   bank: transaction.va_numbers[0].bank,
      // };
      return await midtransSnap.createTransaction(parameter);
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
