/*
 ** PACKAGES NODE MODULES
 */
import { Express } from "express";

/*
 ** ROUTES
 */
import paymentRoute from "./payment-route";

// api endpoint
export default function routes(app: Express) {
  app.use('/billing', paymentRoute);
  app.get("/", (req, res) => {
    res.send("hello world");
  });
}
