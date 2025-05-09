import { Request, Response } from "express";

import Billing from "../models/billing";
import MidtransService from "../services/midtrans-service";

const midtransService = new MidtransService();

export default class PaymentController {
  async createTransaction(req: Request, res: Response) {
    try {
      const billingData = JSON.parse(req.body);

      const result = await midtransService.createVA(billingData);

      if (result) {
        res.status(200).json(result);
      }
    } catch (error: any) {
      res.status(400).json(error.message);
    }
  }

  async checkPaymentStatus(req: Request, res: Response) {
    try {
      const result = await midtransService.checkPaymentStatus(
        req.params.orderId
      );

      res.status(200).json(result);
    } catch (error: any) {
      res.status(400).json(error.message);
    }
  }
}
