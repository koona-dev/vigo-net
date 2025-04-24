const { Router } = require("express");

import UserAccountController from "../controllers/user-account-controller";

// controller
export default class UserAccountRoute {
  // declare authRoute
  static path()  {
    const userAccountController = new UserAccountController();
    const router = Router();
    
    //API
    router.post("/:id", userAccountController.getOneUser);
    router.post("/", userAccountController.getUsers);
    router.post("/create", userAccountController.createUserAccount);
    router.post("/update", userAccountController.updateUserAccount);
    router.post("/delete", userAccountController.deleteUserAccount);

    return router;
  };
}
