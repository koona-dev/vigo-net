const { Router } = require("express");

import UserAccountController from "../controllers/user-account-controller";

// controller
// declare authRoute
const userAccountController = new UserAccountController();
const router = Router();

//API
router.get("/:id", userAccountController.getOneUser);
router.get("/", userAccountController.getUsers);
router.post("/create", userAccountController.createUserAccount);
router.put("/update", userAccountController.updateUserAccount);
router.delete("/delete", userAccountController.deleteUserAccount);

export default router;
