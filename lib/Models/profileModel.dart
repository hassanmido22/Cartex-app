import 'dart:convert';

List<UserProfileModel> userFromJson(String str) => List<UserProfileModel>.from(
    json.decode(str).map((x) => UserProfileModel.fromJson(x)));

String userToJson(List<UserProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfileModel {
  String username;
  String email;
  String password1;
  String password2;
  String gender;
  String phone;
  String birthdate;
  String address;
  String avatar;
  double points;
  List<Payment> payments;

  UserProfileModel({
    this.username,
    this.email,
    this.password1,
    this.password2,
    this.gender,
    this.phone,
    this.birthdate,
    this.address,
    this.avatar,
    this.points,
    this.payments,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        username: json["username"] as String,
        email: json["email"] as String,
        password1: json["password1"] as String,
        password2: json["password2"] as String,
        gender: json["gender"] as String,
        //phone: json["phone"] as String,
        birthdate: json["birthdate"] as String,
        address: json["address"] as String,
        avatar: json["avatar"] as String,
        points: json["points"] as double,
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password1": password1,
        "password2": password2,
        "gender": gender,
        //"phone": phone,
        "birthdate": birthdate,
        "address": address,
        "avatar": avatar,
        "points": points,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };

  Map toMapRegister() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;
    map["password1"] = password1;
    map["password2"] = password2;
    map["gender"] = gender;
    //map["phone"] = phone;
    map["birthdate"] = birthdate;
    map["address"] = address;
    map["avatar"] = avatar;

    return map;
  }
}

class Payment {
  Payment({
    this.paymentNumber,
    this.id,
    this.expiryDate,
    this.username,
    this.user,
    this.cvv,
  });

  String paymentNumber;
  int id;
  String expiryDate;
  String username;
  String user;
  int cvv;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentNumber: json["payment_number"],
        id: json["id"],
        expiryDate: json["Expiry_date"],
        username: json["username"],
        user: json["user"],
        cvv: json["CVV"],
      );

  Map<String, dynamic> toJson() => {
        "payment_number": paymentNumber,
        "id": id,
        "Expiry_date": expiryDate,
        "username": username,
        "user": user,
        "CVV": cvv,
      };
}
