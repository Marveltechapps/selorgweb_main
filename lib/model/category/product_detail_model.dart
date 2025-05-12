import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
    int? status;
    String? message;
    Data? data;
    CartSummary? cartSummary;

    ProductDetailResponse({
        this.status,
        this.message,
        this.data,
        this.cartSummary,
    });

    factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        cartSummary: json["cartSummary"] == null ? null : CartSummary.fromJson(json["cartSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "cartSummary": cartSummary?.toJson(),
    };
}

class CartSummary {
    int? overallProductQuantity;
    int? overallProductPrice;
    List<ProductDetail>? productDetails;

    CartSummary({
        this.overallProductQuantity,
        this.overallProductPrice,
        this.productDetails,
    });

    factory CartSummary.fromJson(Map<String, dynamic> json) => CartSummary(
        overallProductQuantity: json["overallProductQuantity"],
        overallProductPrice: json["overallProductPrice"],
        productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "overallProductQuantity": overallProductQuantity,
        "overallProductPrice": overallProductPrice,
        "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    };
}

class ProductDetail {
    String? productId;
    String? variantLabel;
    int? variantQuantity;
    int? variantPrice;

    ProductDetail({
        this.productId,
        this.variantLabel,
        this.variantQuantity,
        this.variantPrice,
    });

    factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        productId: json["productId"],
        variantLabel: json["variantLabel"],
        variantQuantity: json["variantQuantity"],
        variantPrice: json["variantPrice"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "variantLabel": variantLabel,
        "variantQuantity": variantQuantity,
        "variantPrice": variantPrice,
    };
}

class Data {
    Product? product;
    MainCategory? mainCategory;
    MainCategory? subCategory;

    Data({
        this.product,
        this.mainCategory,
        this.subCategory,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        mainCategory: json["main_category"] == null ? null : MainCategory.fromJson(json["main_category"]),
        subCategory: json["subCategory"] == null ? null : MainCategory.fromJson(json["subCategory"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "main_category": mainCategory?.toJson(),
        "subCategory": subCategory?.toJson(),
    };
}

class MainCategory {
    String? id;
    String? name;
    String? imageUrl;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? mainCategoryId;

    MainCategory({
        this.id,
        this.name,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.mainCategoryId,
    });

    factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        mainCategoryId: json["main_category_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "main_category_id": mainCategoryId,
    };
}

class Product {
    Description? description;
    String? id;
    String? skuCode;
    String? skuName;
    List<Variant>? variants;
    String? skuClassification;
    String? skuClassification1;
    MainCategory? subCategoryId;
    int? price;
    int? discountPrice;
    String? offer;
    String? createdAt;
    String? updatedAt;
    int? v;
    MainCategory? mainCategoryId;

    Product({
        this.description,
        this.id,
        this.skuCode,
        this.skuName,
        this.variants,
        this.skuClassification,
        this.skuClassification1,
        this.subCategoryId,
        this.price,
        this.discountPrice,
        this.offer,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.mainCategoryId,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        id: json["_id"],
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        subCategoryId: json["subCategory_id"] == null ? null : MainCategory.fromJson(json["subCategory_id"]),
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        mainCategoryId: json["main_category_id"] == null ? null : MainCategory.fromJson(json["main_category_id"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "subCategory_id": subCategoryId?.toJson(),
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "main_category_id": mainCategoryId?.toJson(),
    };
}

class Description {
    String? about;
    String? healthBenefits;
    String? nutrition;
    String? origin;

    Description({
        this.about,
        this.healthBenefits,
        this.nutrition,
        this.origin,
    });

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        about: json["about"],
        healthBenefits: json["healthBenefits"],
        nutrition: json["nutrition"],
        origin: json["origin"],
    );

    Map<String, dynamic> toJson() => {
        "about": about,
        "healthBenefits": healthBenefits,
        "nutrition": nutrition,
        "origin": origin,
    };
}

class Variant {
    String? label;
    int? price;
    int? discountPrice;
    String? offer;
    bool? isComboPack;
    bool? isMultiPack;
    ComboDetails? comboDetails;
    int? stockQuantity;
    String? imageUrl;
    int? cartQuantity;
    String? id;
    bool? isOutOfStock;

    Variant({
        this.label,
        this.price,
        this.discountPrice,
        this.offer,
        this.isComboPack,
        this.isMultiPack,
        this.comboDetails,
        this.stockQuantity,
        this.imageUrl,
        this.cartQuantity,
        this.id,
        this.isOutOfStock,
    });

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        label: json["label"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        isComboPack: json["isComboPack"],
        isMultiPack: json["isMultiPack"],
        comboDetails: json["comboDetails"] == null ? null : ComboDetails.fromJson(json["comboDetails"]),
        stockQuantity: json["stockQuantity"],
        imageUrl: json["imageURL"],
        cartQuantity: json["cartQuantity"],
        id: json["_id"],
        isOutOfStock: json["isOutOfStock"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "isComboPack": isComboPack,
        "isMultiPack": isMultiPack,
        "comboDetails": comboDetails?.toJson(),
        "stockQuantity": stockQuantity,
        "imageURL": imageUrl,
        "cartQuantity": cartQuantity,
        "_id": id,
        "isOutOfStock": isOutOfStock,
    };
}

class ComboDetails {
    List<String>? productNames;
    List<String>? childSkuCodes;
    String? comboName;
    String? comboImageUrl;

    ComboDetails({
        this.productNames,
        this.childSkuCodes,
        this.comboName,
        this.comboImageUrl,
    });

    factory ComboDetails.fromJson(Map<String, dynamic> json) => ComboDetails(
        productNames: json["productNames"] == null ? [] : List<String>.from(json["productNames"]!.map((x) => x)),
        childSkuCodes: json["childSkuCodes"] == null ? [] : List<String>.from(json["childSkuCodes"]!.map((x) => x)),
        comboName: json["comboName"],
        comboImageUrl: json["comboImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "productNames": productNames == null ? [] : List<dynamic>.from(productNames!.map((x) => x)),
        "childSkuCodes": childSkuCodes == null ? [] : List<dynamic>.from(childSkuCodes!.map((x) => x)),
        "comboName": comboName,
        "comboImageURL": comboImageUrl,
    };
}
