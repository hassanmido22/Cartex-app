import 'dart:convert';

List<UserRegisterationModel> userFromJson(String str) =>
    List<UserRegisterationModel>.from(json.decode(str).map((x) => UserRegisterationModel.fromJson(x)));

String userToJson(List<UserRegisterationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegisterationModel {
  String username;
  String email;
  String password1;
  String password2;
  String gender;
  String birthdate;
  String address;

  UserRegisterationModel({
    this.username,
    this.email,
    this.password1,
    this.password2,
    this.gender,
    this.birthdate,
    this.address,
  });

  factory UserRegisterationModel.fromJson(Map<String, dynamic> json) => UserRegisterationModel(
        username: json.containsKey('username')
            ? json["username"][0] as String
            : 'null',
        email: json.containsKey('email') ? json["email"][0] as String : 'null',
        password1: json.containsKey('password1')
            ? json["password1"][0] as String
            : 'null',
        password2: json.containsKey('password2')
            ? json["password2"][0] as String
            : 'null',
        gender:
            json.containsKey('gender') ? json["gender"] as String : 'null',
        birthdate: json.containsKey('birthdate')
            ? json["birthdate"][0] as String
            : 'null',
        address:
            json.containsKey('address') ? json["address"][0] as String : 'null',
      );

      

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password1": password1,
        "password2": password2,
        "gender": gender,
        "birthdate": birthdate,
        "address": address,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;
    map["password1"] = password1;
    map["password2"] = password2;
    map["gender"] = gender;
    map["birthdate"] = birthdate;
    map["address"] = address;

    return map;
  }

  Map toMap2() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password1;
    return map;
  }
}
