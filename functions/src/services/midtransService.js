const midtransClient = require("midtrans-client");
const {
  isProduction,
  serverKey,
  clientKey,
} = require("../config/midtransConfig");

const midtrans = new midtransClient.CoreApi({
  isProduction,
  clientKey,
  serverKey,
});

async function createVA(orderId, amount, bank, customerName) {
  let parameter = {
    payment_type: "bank_transfer",
    transaction_details: {
      order_id: orderId,
      gross_amount: amount,
    },
    bank_transfer: {
      bank: bank, // Example: "bca", "bni", "bri"
    },
    customer_details: {
      first_name: customerName,
    },
  };

  try {
    const transaction = await midtrans.charge(parameter);
    return {
      va_number: transaction.va_numbers[0].va_number,
      bank: transaction.va_numbers[0].bank,
    };
  } catch (error) {
    throw new Error(error.message);
  }
}

async function checkPaymentStatus(params) {
  try {
    return await midtrans.transaction.status(orderId);
  } catch (error) {
    throw new Error(error.message);
  }
}

module.exports = { createVA, checkPaymentStatus };
