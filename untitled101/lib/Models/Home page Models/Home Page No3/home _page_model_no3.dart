
class HomePageTopSeller {
  HomePageTopSeller({
    this.status,
    this.dataCount,
    this.data,
  });
  late final String? status;
  late final int? dataCount;
  late final Data? data;

  HomePageTopSeller.fromJson(Map<String, dynamic> json)
      : status = json['status'] ?? '',
        dataCount = json['data_count'] ?? 0,
        data = Data.fromJson(json['data'] ?? {});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data_count'] = dataCount;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.topSeller,
    this.promotedStores,
  });
  late final List<TopSeller>? topSeller;
  late final List<PromotedStores>? promotedStores;

  Data.fromJson(Map<String, dynamic> json)
      : topSeller = (json['top_seller'] as List<dynamic>?)
      ?.map((e) => TopSeller.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
        promotedStores = (json['promoted_stores'] as List<dynamic>?)
            ?.map((e) => PromotedStores.fromJson(e as Map<String, dynamic>))
            .toList() ?? [];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['top_seller'] = topSeller!.map((e) => e.toJson()).toList();
    _data['promoted_stores'] = promotedStores!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TopSeller {
  TopSeller({
    this.shop,
    this.products,
  });
  late final Shop? shop;
  late final List<Products>? products;

  TopSeller.fromJson(Map<String, dynamic> json)
      : shop = Shop.fromJson(json['shop'] ?? {}),
        products = (json['products'] as List<dynamic>?)
            ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
            .toList() ?? [];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shop'] = shop!.toJson();
    _data['products'] = products!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Shop {
  Shop({

    this.cashbackText,
    this.sellerId,
    this.userId,
    this.cashbackTag,
    this.name,
    this.shopImage,
  });


  late final String? cashbackText;
  late final String? sellerId;
  late final int? userId;
  late final String? cashbackTag;
  late final String? name;
  late final String? shopImage;

  Shop.fromJson(Map<String, dynamic> json)
      : cashbackText = json['cashback_text'] ?? '',
        sellerId = json['seller_id'],
        userId = json['user_id'],
        cashbackTag = json['cashback_tag'] ?? '',
        name = json['name'] ?? '',
        shopImage = json['shop_image'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cashback_text'] = cashbackText;
    _data['seller_id'] = sellerId;
    _data['user_id'] = userId;
    _data['cashback_tag'] = cashbackTag;
    _data['name'] = name;
    _data['shop_image'] = shopImage;
    return _data;
  }
}

class Products {
  Products({
    this.cashbackText,
    this.productId,
    this.cashbackTag,
    this.productCategory,
    this.productImage,
    this.productTitle,
  });

  dynamic? cashbackText;
  dynamic? productId;
  dynamic? cashbackTag;
  dynamic? productCategory;
  dynamic? productImage;
  dynamic? productTitle;

  Products.fromJson(Map<String, dynamic> json)
      : cashbackText = json['cashback_text'] ?? '',
        productId = json['product_id'],
        cashbackTag = json['cashback_tag'] ?? '',
        productCategory = json['product_category'],
        productImage = json['product_image'],
        productTitle = json['product_title'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cashback_text'] = cashbackText;
    _data['product_id'] = productId;
    _data['cashback_tag'] = cashbackTag;
    _data['product_category'] = productCategory;
    _data['product_image'] = productImage;
    _data['product_title'] = productTitle;
    return _data;
  }
}

class PromotedStores {
  PromotedStores({
    this.shop,
    this.products,
  });
  late final Shop? shop;
  late final List<Products>? products;

  PromotedStores.fromJson(Map<String, dynamic> json)
      : shop = Shop.fromJson(json['shop'] ?? {}),
        products = (json['products'] as List<dynamic>?)
            ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
            .toList() ?? [];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shop'] = shop!.toJson();
    _data['products'] = products!.map((e) => e.toJson()).toList();
    return _data;
  }
}









// class HomePageTopSeller {
//   HomePageTopSeller({
//     this.status,
//     this.dataCount,
//     this.data,
//   });
//
//   String? status;
//   int? dataCount;
//   Data? data;
//
//   HomePageTopSeller.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     dataCount = json['data_count'];
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['data_count'] = dataCount;
//     _data['data'] = data?.toJson();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     this.topSeller,
//     this.promotedStores,
//   });
//
//   List<TopSeller>? topSeller;
//   List<PromotedStores>? promotedStores;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     topSeller = (json['top_seller'] as List<dynamic>?)
//         ?.map((e) => TopSeller.fromJson(e))
//         .toList();
//     promotedStores = (json['promoted_stores'] as List<dynamic>?)
//         ?.map((e) => PromotedStores.fromJson(e))
//         .toList();
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['top_seller'] = topSeller?.map((e) => e.toJson()).toList();
//     data['promoted_stores'] = promotedStores?.map((e) => e.toJson()).toList();
//     return data;
//   }
// }
//
// class TopSeller {
//   TopSeller({
//     this.shop,
//     this.products,
//   });
//
//   ShopSeller? shop;
//   List<ProductsSeller>? products;
//
//   TopSeller.fromJson(Map<String, dynamic> json) {
//     shop = ShopSeller.fromJson(json['shop']);
//     products = (json['products'] as List<dynamic>?)?.map((e) => ProductsSeller.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['shop'] = shop?.toJson();
//     data['products'] = products?.map((e) => e.toJson()).toList();
//     return data;
//   }
// }
//
// class ShopSeller {
//   ShopSeller({
//     this.sellerId,
//     this.userId,
//     this.name,
//     this.shopImage,
//     this.rating,
//     this.cashbackTag,
//     this.cashbackText,
//   });
//
//   String? sellerId;
//   String? userId;
//   String? name;
//   String? shopImage;
//   String? rating;
//   bool? cashbackTag;
//   String? cashbackText;
//
//   factory ShopSeller.fromJson(Map<String, dynamic> json) {
//     return ShopSeller(
//       sellerId: json['seller_id'] as String? ?? '',
//       userId: json['user_id'] as String? ?? '',
//       name: json['name'] as String? ?? '',
//       shopImage: json['shop_image'] as String? ?? '',
//       rating: json['rating'] as String? ?? '',
//       cashbackTag: json['cashback_tag'] as bool? ?? false,
//       cashbackText: json['cashback_text'] as String? ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['seller_id'] = sellerId;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['shop_image'] = shopImage;
//     data['rating'] = rating;
//     data['cashback_tag'] = cashbackTag;
//     data['cashback_text'] = cashbackText;
//     return data;
//   }
// }
//
// class ProductsSeller {
//   ProductsSeller({
//     this.productId,
//     this.productTitle,
//     this.productCategory,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//   });
//
//   String? productId;
//   String? productTitle;
//   String? productCategory;
//   String? productImage;
//   bool? cashbackTag;
//   String? cashbackText;
//
//   factory ProductsSeller.fromJson(Map<String, dynamic> json) {
//     return ProductsSeller(
//       productId: json['product_id'] as String? ?? '',
//       productTitle: json['product_title'] as String? ?? '',
//       productCategory: json['product_category'] as String? ?? '',
//       productImage: json['product_image'] as String? ?? '',
//       cashbackTag: json['cashback_tag'] as bool? ?? false,
//       cashbackText: json['cashback_text'] as String? ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['product_id'] = productId;
//     data['product_title'] = productTitle;
//     data['product_category'] = productCategory;
//     data['product_image'] = productImage;
//     data['cashback_tag'] = cashbackTag;
//     data['cashback_text'] = cashbackText;
//     return data;
//   }
// }
//
// class PromotedStores {
//   PromotedStores({
//     this.shop,
//     this.products,
//   });
//
//   Shop? shop;
//   List<Products>? products;
//
//   PromotedStores.fromJson(Map<String, dynamic> json) {
//     shop = Shop.fromJson(json['shop']);
//     products = (json['products'] as List<dynamic>?)?.map((e) => Products.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['shop'] = shop?.toJson();
//     data['products'] = products?.map((e) => e.toJson()).toList();
//     return data;
//   }
// }
//
// class Shop {
//   Shop({
//     this.sellerId,
//     this.userId,
//     this.name,
//     this.cashbackTag,
//     this.cashbackText,
//   });
//
//   String? sellerId;
//   String? userId;
//   String? name;
//   bool? cashbackTag;
//   String? cashbackText;
//
//   Shop.fromJson(Map<String, dynamic> json) {
//     sellerId = json['seller_id'];
//     userId = json['user_id'];
//     name = json['name'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['seller_id'] = sellerId;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['cashback_tag'] = cashbackTag;
//     data['cashback_text'] = cashbackText;
//     return data;
//   }
// }
//
// class Products {
//   Products({
//     this.productId,
//     this.createdBy,
//     this.productTitle,
//     this.productSlug,
//     this.productCategory,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//   });
//
//   String? productId;
//   String? createdBy;
//   String? productTitle;
//   String? productSlug;
//   String? productCategory;
//   String? productImage;
//   String? cashbackTag;
//   String? cashbackText;
//
//   Products.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     createdBy = json['created_by'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['product_id'] = productId;
//     data['created_by'] = createdBy;
//     data['product_title'] = productTitle;
//     data['product_slug'] = productSlug;
//     data['product_category'] = productCategory;
//     data['product_image'] = productImage;
//     data['cashback_tag'] = cashbackTag;
//     data['cashback_text'] = cashbackText;
//     return data;
//   }
// }
