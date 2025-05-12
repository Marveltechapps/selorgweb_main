import 'dart:convert';

ProductStyleResponse productStyleResponseFromJson(String str) =>
    ProductStyleResponse.fromJson(json.decode(str));

String productStyleResponseToJson(ProductStyleResponse data) =>
    json.encode(data.toJson());

class ProductStyleResponse {
  int? status;
  String? message;
  List<ProductList>? data;
  Pagination? pagination;

  ProductStyleResponse({
    this.status,
    this.message,
    this.data,
    this.pagination,
  });

  factory ProductStyleResponse.fromJson(Map<String, dynamic> json) =>
      ProductStyleResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProductList>.from(json["data"]!.map((x) => ProductList.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class ProductList {
  String? productId;
  String? mainCategoryId;
  String? mainCategoryName;
  dynamic categoryId;
  dynamic categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? skucode;
  String? skuName;
  List<Variant>? variants;
  String? offer;
  int? discountPrice;

  ProductList({
    this.productId,
    this.mainCategoryId,
    this.mainCategoryName,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.skucode,
    this.skuName,
    this.variants,
    this.offer,
    this.discountPrice,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productId: json["productId"],
        mainCategoryId: json["main_category_id"],
        mainCategoryName: json["mainCategoryName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        skucode: json["skucode"],
        skuName: json["skuName"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        offer: json["offer"],
        discountPrice: json["discountPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "main_category_id": mainCategoryId,
        "mainCategoryName": mainCategoryName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "skucode": skucode,
        "skuName": skuName,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "offer": offer,
        "discountPrice": discountPrice,
      };
}

class Variant {
  String? label;
  int? price;
  int? discountPrice;
  String? offer;
  bool? isComboPack;
  bool? isMultiPack;
  int? stockQuantity;
  bool? isOutOfStock;
  String? imageUrl;
  int? cartQuantity;
  ComboDetails? comboDetails;

  Variant({
    this.label,
    this.price,
    this.discountPrice,
    this.offer,
    this.isComboPack,
    this.isMultiPack,
    this.stockQuantity,
    this.isOutOfStock,
    this.imageUrl,
    this.cartQuantity,
    this.comboDetails,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        label: json["label"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        isComboPack: json["isComboPack"],
        isMultiPack: json["isMultiPack"],
        stockQuantity: json["stockQuantity"],
        isOutOfStock: json["isOutOfStock"],
        imageUrl: json["imageURL"],
        cartQuantity: json["cartQuantity"],
        comboDetails: json["comboDetails"] == null
            ? null
            : ComboDetails.fromJson(json["comboDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "isComboPack": isComboPack,
        "isMultiPack": isMultiPack,
        "stockQuantity": stockQuantity,
        "isOutOfStock": isOutOfStock,
        "imageURL": imageUrl,
        "cartQuantity": cartQuantity,
        "comboDetails": comboDetails?.toJson(),
      };
}

class ComboDetails {
  String? comboName;
  List<String>? productNames;
  List<String>? childSkuCodes;
  String? comboImageUrl;

  ComboDetails({
    this.comboName,
    this.productNames,
    this.childSkuCodes,
    this.comboImageUrl,
  });

  factory ComboDetails.fromJson(Map<String, dynamic> json) => ComboDetails(
        comboName: json["comboName"],
        productNames: json["productNames"] == null
            ? []
            : List<String>.from(json["productNames"]!.map((x) => x)),
        childSkuCodes: json["childSkuCodes"] == null
            ? []
            : List<String>.from(json["childSkuCodes"]!.map((x) => x)),
        comboImageUrl: json["comboImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "comboName": comboName,
        "productNames": productNames == null
            ? []
            : List<dynamic>.from(productNames!.map((x) => x)),
        "childSkuCodes": childSkuCodes == null
            ? []
            : List<dynamic>.from(childSkuCodes!.map((x) => x)),
        "comboImageURL": comboImageUrl,
      };
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalDocuments;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalDocuments,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalDocuments: json["totalDocuments"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalDocuments": totalDocuments,
      };
}
