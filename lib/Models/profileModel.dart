import 'dart:convert';

List<UserProfileModel> userFromJson(String str) =>
    List<UserProfileModel>.from(json.decode(str).map((x) => UserProfileModel.fromJson(x)));

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
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        username: json.containsKey('username')
            ? json["username"] as String
            : 'null',
        email: json.containsKey('email') ? json["email"] as String : 'null',
        password1: json.containsKey('password1')
            ? json["password1"] as String
            : 'null',
        password2: json.containsKey('password2')
            ? json["password2"] as String
            : 'null',
        gender:
            json.containsKey('gender') ? json["gender"] as String : 'null',
        //phone: json["phone"] as String,
        birthdate: json.containsKey('birthdate')
            ? json["birthdate"] as String
            : 'null',
        address:
            json.containsKey('address') ? json["address"] as String : 'null',
        avatar:
            json.containsKey('avatar') ? json["avatar"] as String : 'null',
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
