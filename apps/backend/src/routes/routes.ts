/*
 ** PACKAGES NODE MODULES
 */
import { Express } from "express";

/*
 ** ROUTES
 */
import UserAccountRoute from "./user-account-route";

export default class AppRoutes {
  // api endpoint
  static endpoint(app: Express) {
    app.use("/user-account", UserAccountRoute.path);
  }
}
