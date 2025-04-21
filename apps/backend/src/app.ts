import express from "express";
import cors from "cors";

import { paymentRouter } from "./routes/payment-route";

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

app.use("/payment", paymentRouter);

app.listen("3000", () => {
  console.info(`Server running 🤖🚀 at localhost:3000`);
});
