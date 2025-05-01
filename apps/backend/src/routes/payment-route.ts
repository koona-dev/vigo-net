import express = require("express");
import PaymentController from "../controllers/payment-controller";

// controller
// declare authRoute
const userAccountController = new PaymentController();
const paymentRoute = express.Router();

//API
// Route to create Virtual Account
paymentRoute.post("/create-va", userAccountController.createTransaction);

paymentRoute.get(
  "/check-payment/:orderId",
  userAccountController.checkPaymentStatus
);

export default paymentRoute;
