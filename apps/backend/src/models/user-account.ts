export class User {
  id?: string;
  username?: string;
  password?: string;
  email?: string;
  phone?: string;
  name?: string;
  address?: string;
  photoUrl?: string;
  noKtp?: string;
  housePhotoUrl: any[] = [];
  role: UserRole = UserRole.user;

  constructor(data?: { [keys: string]: any }) {
    if (data) {
      this.id = data.id;
      this.username = data.username;
      this.password = data.password;
      this.email = data.email;
      this.phone = data.phone;
      this.name = data.name;
      this.photoUrl = data.photoUrl;
    }
  }

  static updatePhoneNumber(newPhone: string) {
    const user = new User();
    user.phone = newPhone;
    return user;
  }

  static changePassword(newPsw: string) {
    const user = new User();
    user.phone = newPsw;
  }

  static updateProfile(data: { [keys: string]: any }) {
    const user = new User();
    
    user.name = data.name;
    user.address = data.address;
    user.noKtp = data.noKtp;
    user.photoUrl = data.photoUrl;
    user.housePhotoUrl = data.housePhotoUrl;
  }

  static fromMap(data: { [field: string]: any }): User {
    const user = new User();

    user.id = data.id;
    user.username = data.userName as string;
    user.password = data.password;
    user.email = data.email;
    user.phone = data.phone;
    user.name = data.name;
    user.address = data.address;
    user.photoUrl = data.photoUrl;
    user.noKtp = data.noKtp;
    user.housePhotoUrl = data.housePhotoUrl;
    user.role = data.role;

    return user;
  }

  toMap(): { [field: string]: any } {
    return {
      id: this.id,
      username: this.username,
      password: this.password,
      email: this.email,
      phone: this.phone,
      name: this.name,
      address: this.address,
      photoUrl: this.photoUrl,
      noKtp: this.noKtp,
      housePhotoUrl: this.housePhotoUrl,
      role: this.role,
    };
  }
}

enum UserRole {
  user,
  cp,
  customer,
}
