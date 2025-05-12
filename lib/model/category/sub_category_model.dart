import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
    int? status;
    String? message;
    int? count;
    List<SubCat>? data;

    SubCategory({
        this.status,
        this.message,
        this.count,
        this.data,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<SubCat>.from(json["data"]!.map((x) => SubCat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubCat {
    String? id;
    String? name;
    String? imageUrl;
    String? createdAt;
    String? updatedAt;
    int? v;
    CategoryId? categoryId;

    SubCat({
        this.id,
        this.name,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.categoryId,
    });

    factory SubCat.fromJson(Map<String, dynamic> json) => SubCat(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        categoryId: json["category_id"] == null ? null : CategoryId.fromJson(json["category_id"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "category_id": categoryId?.toJson(),
    };
}

class CategoryId {
    String? id;
    String? name;

    CategoryId({
        this.id,
        this.name,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
