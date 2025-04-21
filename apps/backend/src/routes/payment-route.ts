import express = require("express");

import { createVA, checkPaymentStatus } from "../services/midtrans-service";

export const paymentRouter = express.Router();

// Route to create Virtual Account
paymentRouter.post("/createVA", async (req, res) => {
  try {
    const { orderId, amount, bank, customerName } = req.body;
    const vaData = await createVA(orderId, amount, bank, customerName);
    res.json(vaData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

paymentRouter.get("/checkPayment/:orderId", async (req, res) => {
  try {
    const { orderId } = req.params;
    const transaction = await checkPaymentStatus(orderId);
    res.json(transaction);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
