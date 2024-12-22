// ignore_for_file: constant_identifier_names

import 'dart:convert';

SellerProductsDetails sellerProductsDetailsFromJson(String str) => SellerProductsDetails.fromJson(json.decode(str));

String sellerProductsDetailsToJson(SellerProductsDetails data) => json.encode(data.toJson());

class SellerProductsDetails {
    String? status;
    int? totalPages;
    int? pageNo;
    int? limit;
    int? offset;
    int? count;
    String? totalCount;
    List<Product>? products;

  SellerProductsDetails({
    this.status,
    this.totalPages,
    this.pageNo,
    this.limit,
    this.offset,
    this.count,
    this.totalCount,
    this.products,
  });

  factory SellerProductsDetails.fromJson(Map<String, dynamic> json) => SellerProductsDetails(
    status: json["status"],
    totalPages: json["total_pages"],
    pageNo: json["page_no"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    totalCount: json["total_count"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_pages": totalPages,
    "page_no": pageNo,
    "limit": limit,
    "offset": offset,
    "count": count,
    "total_count": totalCount,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
    String? productId;
    String? cloneId;
    String? productSlug;
    String? imgGroupId;
    String? showPrice;
    String? productName;
    String? model;
    String? price;
    String? offerPrice;
    String? stockQuantity;
    String? isActive;
    String? isApproved;
    String? categoryName;
    String? imageFile;
    String? brand;
    DateTime? createdDate;
    StoreName? storeName;
    String? storeDescription;
    String? productImgUrl;
    String? wishedVal;
    String? likeVal;
    bool? cashbackTag;
    String? cashbackText;
    dynamic contactNo;
    String? shareLink;
    String? whatsapptext;
    String? wantToBuy;

  Product({
    this.productId,
    this.cloneId,
    this.productSlug,
    this.imgGroupId,
    this.showPrice,
    this.productName,
    this.model,
    this.price,
    this.offerPrice,
    this.stockQuantity,
    this.isActive,
    this.isApproved,
    this.categoryName,
    this.imageFile,
    this.brand,
    this.createdDate,
    this.storeName,
    this.storeDescription,
    this.productImgUrl,
    this.wishedVal,
    this.likeVal,
    this.cashbackTag,
    this.cashbackText,
    this.contactNo,
    this.shareLink,
    this.whatsapptext,
    this.wantToBuy,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    cloneId: json["clone_id"],
    productSlug: json["product_slug"],
    imgGroupId: json["img_group_id"],
    showPrice: json["show_price"],
    productName: json["product_name"],
    model: json["model"],
    price: json["price"],
    offerPrice: json["offer_price"],
    stockQuantity: json["stock_quantity"],
    isActive: json["is_active"],
    isApproved: json["is_approved"],
    categoryName: json["category_name"],
    imageFile: json["image_file"],
    brand: json["brand"],
    //createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    createdDate: json["created_date"] != null ? DateTime.parse(json["created_date"]) : null,
    storeName: storeNameValues.map[json["store_name"]] ?? StoreName.EMPTY,
    // storeName: storeNameValues.map[json["store_name"]]!,
    storeDescription: json["store_description"],
    productImgUrl: json["product_img_url"],
    wishedVal: json["wished_val"],
    likeVal: json["like_val"],
    cashbackTag: json["cashback_tag"],
    cashbackText: json["cashback_text"],
    contactNo: json["contact_no"],
    shareLink: json["share_link"],
    whatsapptext: json["whatsapptext"],
    wantToBuy: json["want_to_buy"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "clone_id": cloneId,
    "product_slug": productSlug,
    "img_group_id": imgGroupId,
    "show_price": showPrice,
    "product_name": productName,
    "model": model,
    "price": price,
    "offer_price": offerPrice,
    "stock_quantity": stockQuantity,
    "is_active": isActive,
    "is_approved": isApproved,
    "category_name": categoryName,
    "image_file": imageFile,
    "brand": brand,
    "created_date": createdDate?.toIso8601String(),
    "store_name": storeNameValues.reverse[storeName],
    "store_description": storeDescription,
    "product_img_url": productImgUrl,
    "wished_val": wishedVal,
    "like_val": likeVal,
    "cashback_tag": cashbackTag,
    "cashback_text": cashbackText,
    "contact_no": contactNo,
    "share_link": shareLink,
    "whatsapptext": whatsapptext,
    "want_to_buy": wantToBuy,
  };
}

enum StoreName {
  EMPTY,
  SAKSHI_COLLECTION
}

  EnumValues<StoreName> storeNameValues = EnumValues({
  "": StoreName.EMPTY,
  "SAKSHI COLLECTION": StoreName.SAKSHI_COLLECTION
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
