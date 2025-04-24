import { firebaseAuth, firestore } from "../config/firebase-admin-config";
import { User } from "../models/user-account";
import getFilteredQuery from "../utils/firestore-filter";

export default class UserAccountService {
  private userRepo = firestore.collection("users");

  // findOne
  async findOne(uid: string): Promise<User> {
    try {
      const docSnap = await this.userRepo.doc(uid).get();

      return User.fromMap(docSnap.data() as { [field: string]: any });
    } catch (error: any) {
      throw new Error(error);
    }
  }

  async findMany(filter: { [key: string]: any }[]): Promise<User[]> {
    try {
      const docSnap = await getFilteredQuery("users", filter).get();

      return docSnap.docs.map((doc) => {
        return User.fromMap(doc.data());
      });
    } catch (error: any) {
      throw new Error(error);
    }
  }

  // create
  async create(data: User): Promise<void> {
    try {
      const userRecord = await firebaseAuth.createUser({
        email: data.email,
        password: data.password,
        displayName: data.name,
        photoURL: data.photoUrl,
        phoneNumber: data.phone,
      });

      await this.userRepo.doc(userRecord.uid).set({
        id: userRecord.uid,
        ...data.toMap(),
      });
    } catch (error: any) {
      throw new Error(error);
    }
  }

  async update(
    uid: string,
    filter: {
      [field: string]: any;
    }[],
    data: User
  ): Promise<void> {
    try {
      await firebaseAuth.updateUser(uid, data);

      const dataQuery = await getFilteredQuery("users", filter).get();

      dataQuery.docs.forEach((doc) => doc.ref.update(data.toMap()));
    } catch (error: any) {
      throw new Error(error);
    }
  }

  async remove(uid: string): Promise<void> {
    try {
      await this.userRepo.doc(uid).delete();
    } catch (error: any) {
      throw new Error(error);
    }
  }
}
