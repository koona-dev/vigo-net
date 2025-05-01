// import dotenv from "dotenv";

// // load env file
// dotenv.config({ path: ".env" });

const Midtrans = require("midtrans-client");

const midtransConfig = {
  isProduction: false, // Change to true for live transactions
  clientKey: process.env.CLIENT_KEY,
  serverKey: process.env.SERVER_KEY,
};

const midtransSnap = new Midtrans.Snap(midtransConfig);
export default midtransSnap;
