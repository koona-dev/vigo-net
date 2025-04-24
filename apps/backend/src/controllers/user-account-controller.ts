import { Request, Response } from "express";

import UserAccountService from "../services/user-account-service";
import { User } from "../models/user-account";

export default class UserAccountController {
  private userAccountService = new UserAccountService();

  async getOneUser(req: Request, res: Response) {
    const id = req.params.id;
    const result = await this.userAccountService.findOne(id);

    if (result) {
      res.status(200).json(result.toMap());
    }
  }

  async getUsers(req: Request, res: Response) {
    const filter = JSON.parse(JSON.stringify(req.body)) as {
      [key: string]: any;
    }[];

    const result = await this.userAccountService.findMany(filter);

    res.status(200).json(result.map((user) => user.toMap()));
  }

  async createUserAccount(req: Request, res: Response) {
    const data = req.body;
    await this.userAccountService.create(User.fromMap(data));
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

    await this.userAccountService.update(id, filter, User.fromMap(data));

    res.status(200).json({ message: "success" });
  }

  async deleteUserAccount(req: Request, res: Response) {
    const id = req.params.id;
    await this.userAccountService.remove(id);

    res.status(200).json({ message: "success" });
  }
}
