/*
 ** PACKAGES NODE MODULES
 */
import { Express } from "express";

/*
 ** ROUTES
 */
import authRoute from "./auth-route";

// api endpoint
function routes(app: Express) {
  app.use("/auth", authRoute);
}

export default routes;
