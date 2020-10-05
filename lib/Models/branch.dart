// To parse this JSON data, do
//
//     final branch = branchFromJson(jsonString);

import 'dart:convert';

Branch branchFromJson(String str) => Branch.fromJson(json.decode(str));

String branchToJson(Branch data) => json.encode(data.toJson());

class Branch {
    Branch({
        this.name,
        this.qrCode,
        this.id,
    });

    String name;
    String qrCode;
    int id;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"],
        qrCode: json["QR_code"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "QR_code": qrCode,
        "id": id,
    };
}