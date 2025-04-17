const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");

const paymentRoutes = require("./routes/paymentRoutes");

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

app.use("/payment", paymentRoutes);

exports.api = functions.https.onRequest(app);

app.listen('3000', () => {
  console.info(`Server running 🤖🚀 at localhost:3000`);
});
