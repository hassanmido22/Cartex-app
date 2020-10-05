// To parse this JSON data, do
//
//     final recommendationlist = recommendationlistFromJson(jsonString);

import 'dart:convert';

List<Recommendationlist> recommendationlistFromJson(String str) => List<Recommendationlist>.from(json.decode(str).map((x) => Recommendationlist.fromJson(x)));

String recommendationlistToJson(List<Recommendationlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recommendationlist {
  
    Recommendationlist({
        this.lhs,
        this.rhs,
        this.support,
        this.confidence,
        this.lift,
        this.count,
        this.row,
    });

    String lhs;
    String rhs;
    double support;
    double confidence;
    double lift;
    int count;
    String row;

    factory Recommendationlist.fromJson(Map<String, dynamic> json) => Recommendationlist(
        lhs: json["lhs"],
        rhs: json["rhs"],
        support: json["support"].toDouble(),
        confidence: json["confidence"].toDouble(),
        lift: json["lift"].toDouble(),
        count: json["count"],
        row: json["_row"],
    );

    Map<String, dynamic> toJson() => {
        "lhs": lhs,
        "rhs": rhs,
        "support": support,
        "confidence": confidence,
        "lift": lift,
        "count": count,
        "_row": row,
    };
}
