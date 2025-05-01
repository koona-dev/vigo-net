import { Request, Response } from "express";

import UserAccountService from "../services/user-account-service";
import { User } from "../models/user-account";

let userAccountService = new UserAccountService();

export default class UserAccountController {  

  async getOneUser(req: Request, res: Response) {
    const id = req.params.id;
    const result = await userAccountService.findOne(id);

    if (result) {
      res.status(200).json(result.toMap());
    }
  }

  async getUsers(req: Request, res: Response) {
    const filter: {
      [key: string]: any;
    }[] = req.body;

    const result = await userAccountService.findMany();

    res.status(200).json(result.map((user) => user.toMap()));
  }

  async createUserAccount(req: Request, res: Response) {
    const data = req.body;
    await userAccountService.create(User.fromMap(data));
    res.status(200).json({ message: "success" });
  }

  async updateUserAccount(req: Request, res: Response) {
    const id = req.params.id;
    const filter = req.body.filter as {
      [field: string]: any;
    }[];
    const data = req.body.data as {
      [field: string]: any;
    };

    await userAccountService.update(id, filter, User.fromMap(data));

    res.status(200).json({ message: "success" });
  }

  async deleteUserAccount(req: Request, res: Response) {
    const id = req.params.id;
    await userAccountService.remove(id);

    res.status(200).json({ message: "success" });
  }
}
