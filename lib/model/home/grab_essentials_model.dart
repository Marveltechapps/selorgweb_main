import 'dart:convert';

GrabandEssential grabandEssentialFromJson(String str) => GrabandEssential.fromJson(json.decode(str));

String grabandEssentialToJson(GrabandEssential data) => json.encode(data.toJson());

class GrabandEssential {
    int? status;
    String? message;
    List<Datum>? data;

    GrabandEssential({
        this.status,
        this.message,
        this.data,
    });

    factory GrabandEssential.fromJson(Map<String, dynamic> json) => GrabandEssential(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? imageUrl;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Datum({
        this.id,
        this.imageUrl,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        imageUrl: json["imageURL"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "imageURL": imageUrl,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
