const { Router } = require("express");

// controller
const authController = require("./auth-controller");

// declare authRoute
const authRoute = Router();

//API
authRoute.post("/login", authController.login);
authRoute.post("/signup", authController.signup);
authRoute.put("/reset-password", authController.changePassword);
authRoute.post("/logout", authController.logout);

export default authRoute;


