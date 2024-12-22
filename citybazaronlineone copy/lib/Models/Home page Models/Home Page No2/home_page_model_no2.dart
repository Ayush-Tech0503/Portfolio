// class Homepage2Data {
//   Homepage2Data({
//     this.status,
//     this.dataCount,
//     this.data,
//   });
//   String? status;
//   int? dataCount;
//   Data? data;
//
//   Homepage2Data.fromJson(Map<String, dynamic> json){
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
//     this.bestProductMobileElectonicProducts,
//     this.jewellery,
//     this.furniture,
//     this.topRatingStore,
//     this.topHomeKitchenProducts,
//     this.famousStore,
//     this.rentals,
//     this.topHealthProducts,
//     this.adsBannerMiddle2,
//     this.adsBannerBottom,
//     this.recentSearches,
//   });
//   List<BestProductMobileElectonicProducts>? bestProductMobileElectonicProducts;
//   List<Jewellery>? jewellery;
//   List<Furniture>? furniture;
//   List<TopRatingStore>? topRatingStore;
//   List<TopHomeKitchenProducts>? topHomeKitchenProducts;
//   List<FamousStore>? famousStore;
//   List<Rentals>? rentals;
//   List<dynamic>? topHealthProducts;
//   List<AdsBannerMiddle2>? adsBannerMiddle2;
//   List<AdsBannerBottom>? adsBannerBottom;
//   // List<dynamic>? recentSearches;
//   List<RecentSearches>? recentSearches;
//
//   Data.fromJson(Map<String, dynamic> json){
//     bestProductMobileElectonicProducts = (json['best_product_mobile_electonic_products'] as List<dynamic>?)
//         ?.map((e) => BestProductMobileElectonicProducts.fromJson(e))
//         .toList();
//     jewellery = (json['Jewellery'] as List<dynamic>?)
//         ?.map((e) => Jewellery.fromJson(e))
//         .toList();
//     furniture = (json['Furniture'] as List<dynamic>?)
//         ?.map((e) => Furniture.fromJson(e))
//         .toList();
//     topRatingStore = (json['top_rating_store'] as List<dynamic>?)
//         ?.map((e) => TopRatingStore.fromJson(e))
//         .toList();
//     topHomeKitchenProducts = (json['top_home_kitchen_products'] as List<dynamic>?)
//         ?.map((e) => TopHomeKitchenProducts.fromJson(e))
//         .toList();
//     famousStore = (json['famous_store'] as List<dynamic>?)
//         ?.map((e) => FamousStore.fromJson(e))
//         .toList();
//     rentals = (json['rentals'] as List<dynamic>?)
//         ?.map((e) => Rentals.fromJson(e))
//         .toList();
//     topHealthProducts = json['top_health_products'] as List<dynamic>?;
//     adsBannerMiddle2 = (json['ads_banner_middle2'] as List<dynamic>?)
//         ?.map((e) => AdsBannerMiddle2.fromJson(e))
//         .toList();
//     adsBannerBottom = (json['ads_banner_bottom'] as List<dynamic>?)
//         ?.map((e) => AdsBannerBottom.fromJson(e))
//         .toList();
//     recentSearches = List.from(json['recent_searches']).map((e)=>RecentSearches.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['best_product_mobile_electonic_products'] = bestProductMobileElectonicProducts?.map((e) => e.toJson()).toList();
//     _data['Jewellery'] = jewellery?.map((e) => e.toJson()).toList();
//     _data['Furniture'] = furniture?.map((e) => e.toJson()).toList();
//     _data['top_rating_store'] = topRatingStore?.map((e) => e.toJson()).toList();
//     _data['top_home_kitchen_products'] = topHomeKitchenProducts?.map((e) => e.toJson()).toList();
//     _data['famous_store'] = famousStore?.map((e) => e.toJson()).toList();
//     _data['rentals'] = rentals?.map((e) => e.toJson()).toList();
//     _data['top_health_products'] = topHealthProducts;
//     _data['ads_banner_middle2'] = adsBannerMiddle2?.map((e) => e.toJson()).toList();
//     _data['ads_banner_bottom'] = adsBannerBottom?.map((e) => e.toJson()).toList();
//   _data['recent_searches'] = recentSearches?.map((e)=>e.toJson()).toList();
//      // _data['recent_searches'] = recentSearches;
//
//     return _data;
//   }
// }
//
// class BestProductMobileElectonicProducts {
//   BestProductMobileElectonicProducts({
//     this.createdBy,
//     this.productId,
//     this.productTitle,
//     this.productSlug,
//     this.productCategory,
//     this.price,
//     this.offerPrice,
//     this.storeName,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//     this.storeSlug,
//     this.contactNo,
//     this.shareLink,
//     this.whatsapptext,
//     this.wantToBuy,
//   });
//   String? createdBy;
//   String? productId;
//   String? productTitle;
//   String? productSlug;
//   String? productCategory;
//   String? price;
//   String? offerPrice;
//   String? storeName;
//   String? productImage;
//   bool? cashbackTag;
//   String? cashbackText;
//   String? storeSlug;
//   String? contactNo;
//   String? shareLink;
//   String? whatsapptext;
//   String? wantToBuy;
//
//   BestProductMobileElectonicProducts.fromJson(Map<String, dynamic> json){
//     createdBy = json['created_by'];
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     price = json['price'];
//     offerPrice = json['offer_price'];
//     storeName = json['store_name'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//     storeSlug = json['store_slug'];
//     contactNo = json['contact_no'];
//     shareLink = json['share_link'];
//     whatsapptext = json['whatsapptext'];
//     wantToBuy = json['want_to_buy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['created_by'] = createdBy;
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['price'] = price;
//     _data['offer_price'] = offerPrice;
//     _data['store_name'] = storeName;
//     _data['product_image'] = productImage;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     _data['store_slug'] = storeSlug;
//     _data['contact_no'] = contactNo;
//     _data['share_link'] = shareLink;
//     _data['whatsapptext'] = whatsapptext;
//     _data['want_to_buy'] = wantToBuy;
//     return _data;
//   }
// }
//
// class Jewellery {
//   Jewellery({
//     this.createdBy,
//     this.productId,
//     this.productTitle,
//     this.productSlug,
//     this.productCategory,
//     this.price,
//     this.offerPrice,
//     this.storeName,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//     this.storeSlug,
//     this.contactNo,
//     this.shareLink,
//     this.whatsapptext,
//     this.wantToBuy,
//   });
//   String? createdBy;
//   String? productId;
//   String? productTitle;
//   String? productSlug;
//   String? productCategory;
//   String? price;
//   String? offerPrice;
//   String? storeName;
//   String? productImage;
//   bool? cashbackTag;
//   String? cashbackText;
//   String? storeSlug;
//   String? contactNo;
//   String? shareLink;
//   String? whatsapptext;
//   String? wantToBuy;
//
//   Jewellery.fromJson(Map<String, dynamic> json){
//     createdBy = json['created_by'];
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     price = json['price'];
//     offerPrice = json['offer_price'];
//     storeName = json['store_name'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//     storeSlug = json['store_slug'];
//     contactNo = json['contact_no'];
//     shareLink = json['share_link'];
//     whatsapptext = json['whatsapptext'];
//     wantToBuy = json['want_to_buy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['created_by'] = createdBy;
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['price'] = price;
//     _data['offer_price'] = offerPrice;
//     _data['store_name'] = storeName;
//     _data['product_image'] = productImage;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     _data['store_slug'] = storeSlug;
//     _data['contact_no'] = contactNo;
//     _data['share_link'] = shareLink;
//     _data['whatsapptext'] = whatsapptext;
//     _data['want_to_buy'] = wantToBuy;
//     return _data;
//   }
// }
//
// class Furniture {
//   Furniture({
//     this.createdBy,
//     this.productId,
//     this.productTitle,
//     this.productSlug,
//     this.productCategory,
//     this.price,
//     this.offerPrice,
//     this.storeName,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//     this.storeSlug,
//     this.contactNo,
//     this.shareLink,
//     this.whatsapptext,
//     this.wantToBuy,
//   });
//   String? createdBy;
//   String? productId;
//   String? productTitle;
//   String? productSlug;
//   String? productCategory;
//   String? price;
//   String? offerPrice;
//   String? storeName;
//   String? productImage;
//   bool? cashbackTag;
//   String? cashbackText;
//   String? storeSlug;
//   String? contactNo;
//   String? shareLink;
//   String? whatsapptext;
//   String? wantToBuy;
//
//   Furniture.fromJson(Map<String, dynamic> json){
//     createdBy = json['created_by'];
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     price = json['price'];
//     offerPrice = json['offerPrice'];
//     // offerPrice = null;
//     storeName = json['store_name'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//     storeSlug = json['store_slug'];
//     contactNo = json['contact_no'];
//     shareLink = json['share_link'];
//     whatsapptext = json['whatsapptext'];
//     wantToBuy = json['want_to_buy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['created_by'] = createdBy;
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['price'] = price;
//     _data['offer_price'] = offerPrice;
//     _data['store_name'] = storeName;
//     _data['product_image'] = productImage;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     _data['store_slug'] = storeSlug;
//     _data['contact_no'] = contactNo;
//     _data['share_link'] = shareLink;
//     _data['whatsapptext'] = whatsapptext;
//     _data['want_to_buy'] = wantToBuy;
//     return _data;
//   }
// }

// class TopRatingStore {
//   TopRatingStore({
//     this.sellerId,
//     this.contactNo,
//     this.address,
//     this.name,
//     this.storeSlug,
//     this.shopImage,
//     this.ratingNumber,
//     this.distanceKm,
//     this.cashbackTag,
//     this.cashbackText,
//     this.shareLink,
//     this.whatsapptext,
//     this.wantToBuy,
//   });
//   String? sellerId;
//   String? contactNo;
//   String? address;
//   String? name;
//   String? storeSlug;
//   String? shopImage;
//   String? ratingNumber;
//   String? distanceKm;
//   bool? cashbackTag;
//   String? cashbackText;
//   String? shareLink;
//   String? whatsapptext;
//   String? wantToBuy;
//
//   TopRatingStore.fromJson(Map<String, dynamic> json){
//     sellerId = json['seller_id'];
//     contactNo = json['contact_no'];
//     address = json['address'];
//     name = json['name'];
//     storeSlug = json['store_slug'];
//     shopImage = json['shop_image'];
//     ratingNumber = json['rating_number'];
//     distanceKm = json['distance_km'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//     shareLink = json['share_link'];
//     whatsapptext = json['whatsapptext'];
//     wantToBuy = json['want_to_buy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['seller_id'] = sellerId;
//     _data['contact_no'] = contactNo;
//     _data['address'] = address;
//     _data['name'] = name;
//     _data['store_slug'] = storeSlug;
//     _data['shop_image'] = shopImage;
//     _data['rating_number'] = ratingNumber;
//     _data['distance_km'] = distanceKm;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     _data['share_link'] = shareLink;
//     _data['whatsapptext'] = whatsapptext;
//     _data['want_to_buy'] = wantToBuy;
//     return _data;
//   }
// }
//
// class TopHomeKitchenProducts {
//   TopHomeKitchenProducts({
//     this.createdBy,
//     this.productId,
//     this.productTitle,
//     this.productSlug,
//     this.productCategory,
//     this.price,
//     this.offerPrice,
//     this.storeName,
//     this.productImage,
//     this.cashbackTag,
//     this.cashbackText,
//     this.storeSlug,
//     this.contactNo,
//     this.shareLink,
//     this.whatsapptext,
//     this.wantToBuy,
//   });
//   String? createdBy;
//   String? productId;
//   String? productTitle;
//   String? productSlug;
//   String? productCategory;
//   String? price;
//   String? offerPrice;
//   String? storeName;
//   String? productImage;
//   bool? cashbackTag;
//   String? cashbackText;
//   String? storeSlug;
//   String? contactNo;
//   String? shareLink;
//   String? whatsapptext;
//   String? wantToBuy;
//
//   TopHomeKitchenProducts.fromJson(Map<String, dynamic> json){
//     createdBy = json['created_by'];
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     price = json['price'];
//     offerPrice = json['offer_price'];
//     storeName = json['store_name'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//     storeSlug = json['store_slug'];
//     contactNo = json['contact_no'];
//     shareLink = json['share_link'];
//     whatsapptext = json['whatsapptext'];
//     wantToBuy = json['want_to_buy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['created_by'] = createdBy;
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['price'] = price;
//     _data['offer_price'] = offerPrice;
//     _data['store_name'] = storeName;
//     _data['product_image'] = productImage;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     _data['store_slug'] = storeSlug;
//     _data['contact_no'] = contactNo;
//     _data['share_link'] = shareLink;
//     _data['whatsapptext'] = whatsapptext;
//     _data['want_to_buy'] = wantToBuy;
//     return _data;
//   }
// }
//
// class FamousStore {
//   FamousStore({
//     this.sellerId,
//     this.storeSlug,
//     this.userId,
//     this.name,
//     this.shopImage,
//     this.rating,
//     this.cashbackTag,
//     this.cashbackText,
//   });
//   String? sellerId;
//   String? storeSlug;
//   String? userId;
//   String? name;
//   String? shopImage;
//   String? rating;
//   bool? cashbackTag;
//   String? cashbackText;
//
//   FamousStore.fromJson(Map<String, dynamic> json){
//     sellerId = json['seller_id'];
//     storeSlug = json['store_slug'];
//     userId = json['user_id'];
//     name = json['name'];
//     shopImage = json['shop_image'];
//     rating = json['rating'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['seller_id'] = sellerId;
//     _data['store_slug'] = storeSlug;
//     _data['user_id'] = userId;
//     _data['name'] = name;
//     _data['shop_image'] = shopImage;
//     _data['rating'] = rating;
//     _data['cashback_tag'] = cashbackTag;
//     _data['cashback_text'] = cashbackText;
//     return _data;
//   }
// }
//
// class Rentals {
//   Rentals({
//     this.rentTitle,
//     this.rentImage,
//   });
//   String? rentTitle;
//   String? rentImage;
//
//   Rentals.fromJson(Map<String, dynamic> json){
//     rentTitle = json['rent_title'];
//     rentImage = json['rent_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['rent_title'] = rentTitle;
//     _data['rent_image'] = rentImage;
//     return _data;
//   }
// }
//
// class AdsBannerMiddle2 {
//   AdsBannerMiddle2({
//     this.bannerImage,
//     this.type,
//     this.whatsapptext,
//     this.keyword,
//     this.bannerTitle,
//     this.discount,
//   });
//   String? bannerImage;
//   String? type;
//   String? whatsapptext;
//   String? keyword;
//   String? bannerTitle;
//   dynamic discount;
//
//   AdsBannerMiddle2.fromJson(Map<String, dynamic> json){
//     bannerImage = json['banner_image'];
//     type = json['type'];
//     whatsapptext = json['type'];
//     // whatsapptext = null;
//     keyword = json['keyword'];
//     bannerTitle = json['banner_title'];
//     discount = json['discount'];
//     // discount = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['banner_image'] = bannerImage;
//     _data['type'] = type;
//     _data['whatsapptext'] = whatsapptext;
//     _data['keyword'] = keyword;
//     _data['banner_title'] = bannerTitle;
//     _data['discount'] = discount;
//     return _data;
//   }
// }
//
// class AdsBannerBottom {
//   AdsBannerBottom({
//     this.bannerImage,
//     this.type,
//     this.whatsapptext,
//     this.keyword,
//     this.bannerTitle,
//     this.discount,
//   });
//   String? bannerImage;
//   String? type;
//   String? whatsapptext;
//   String? keyword;
//   String? bannerTitle;
//   dynamic discount;
//
//   AdsBannerBottom.fromJson(Map<String, dynamic> json){
//     bannerImage = json['banner_image'];
//     type = json['type'];
//     whatsapptext = json['whatsapptext'];
//     // whatsapptext = null;
//     keyword = json['keyword'];
//     bannerTitle = json['banner_title'];
//     discount = json['discount'];
//     // discount = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['banner_image'] = bannerImage;
//     _data['type'] = type;
//     _data['whatsapptext'] = whatsapptext;
//     _data['keyword'] = keyword;
//     _data['banner_title'] = bannerTitle;
//     _data['discount'] = discount;
//     return _data;
//   }
// }
//
// class RecentSearches {
//   RecentSearches({
//     required this.dataId,
//     required this.rsTitle,
//     required this.rcImage,
//     required this.searchDate,
//     required this.dataType,
//     required this.cashbackTag,
//     required this.cashbackText,
//   });
//   late final String dataId;
//   late final String rsTitle;
//   late final String rcImage;
//   late final String searchDate;
//   late final String dataType;
//   late final bool cashbackTag;
//   late final String cashbackText;
//
//   RecentSearches.fromJson(Map<String, dynamic> json){
//     dataId = json['data_id'];
//     rsTitle = json['rs_title'];
//     rcImage = json['rc_image'];
//     searchDate = json['search_date'];
//     dataType = json['data_type'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['data_id'] = dataId;
//     data['rs_title'] = rsTitle;
//     data['rc_image'] = rcImage;
//     data['search_date'] = searchDate;
//     data['data_type'] = dataType;
//     data['cashback_tag'] = cashbackTag;
//     data['cashback_text'] = cashbackText;
//     return data;
//   }
// }



class Homepage2Data {
  String? status;
  int? dataCount;
  Data? data;

  Homepage2Data({this.status, this.dataCount, this.data});

  Homepage2Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataCount = json['data_count'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data_count'] = dataCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<BestProductMobileElectonicProducts>? bestProductMobileElectonicProducts;
  List<Jewellery>? jewellery;
  List<Furniture>? furniture;
  List<TopRatingStore>? topRatingStore;
  List<TopHomeKitchenProducts>? topHomeKitchenProducts;
  List<FamousStore>? famousStore;
  List<Rentals>? rentals;
  List<TopHealthProducts>? topHealthProducts;
  List<AdsBannerMiddle2>? adsBannerMiddle2;
  List<AdsBannerBottom>? adsBannerBottom;
  List<RecentSearches>? recentSearches;

  Data(
      {this.bestProductMobileElectonicProducts,
        this.jewellery,
        this.furniture,
        this.topRatingStore,
        this.topHomeKitchenProducts,
        this.famousStore,
        this.rentals,
        this.topHealthProducts,
        this.adsBannerMiddle2,
        this.adsBannerBottom,
        this.recentSearches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['best_product_mobile_electonic_products'] != null) {
      bestProductMobileElectonicProducts =
      <BestProductMobileElectonicProducts>[];
      json['best_product_mobile_electonic_products'].forEach((v) {
        bestProductMobileElectonicProducts!
            .add(BestProductMobileElectonicProducts.fromJson(v));
      });
    }
    if (json['Jewellery'] != null) {
      jewellery = <Jewellery>[];
      json['Jewellery'].forEach((v) {
        jewellery!.add(Jewellery.fromJson(v));
      });
    }
    if (json['Furniture'] != null) {
      furniture = <Furniture>[];
      json['Furniture'].forEach((v) {
        furniture!.add(Furniture.fromJson(v));
      });
    }
    if (json['top_rating_store'] != null) {
      topRatingStore = <TopRatingStore>[];
      json['top_rating_store'].forEach((v) {
        topRatingStore!.add(TopRatingStore.fromJson(v));
      });
    }
    if (json['top_home_kitchen_products'] != null) {
      topHomeKitchenProducts = <TopHomeKitchenProducts>[];
      json['top_home_kitchen_products'].forEach((v) {
        topHomeKitchenProducts!.add(TopHomeKitchenProducts.fromJson(v));
      });
    }
    if (json['famous_store'] != null) {
      famousStore = <FamousStore>[];
      json['famous_store'].forEach((v) {
        famousStore!.add(FamousStore.fromJson(v));
      });
    }
    if (json['rentals'] != null) {
      rentals = <Rentals>[];
      json['rentals'].forEach((v) {
        rentals!.add(Rentals.fromJson(v));
      });
    }
    if (json['top_health_products'] != null) {
      topHealthProducts = <TopHealthProducts>[];
      json['top_health_products'].forEach((v) {
        topHealthProducts!.add(TopHealthProducts.fromJson(v));
      });
    }
    if (json['ads_banner_middle2'] != null) {
      adsBannerMiddle2 = <AdsBannerMiddle2>[];
      json['ads_banner_middle2'].forEach((v) {
        adsBannerMiddle2!.add(AdsBannerMiddle2.fromJson(v));
      });
    }
    if (json['ads_banner_bottom'] != null) {
      adsBannerBottom = <AdsBannerBottom>[];
      json['ads_banner_bottom'].forEach((v) {
        adsBannerBottom!.add(AdsBannerBottom.fromJson(v));
      });
    }
    if (json['recent_searches'] != null) {
      recentSearches = <RecentSearches>[];
      json['recent_searches'].forEach((v) {
        recentSearches!.add(RecentSearches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bestProductMobileElectonicProducts != null) {
      data['best_product_mobile_electonic_products'] = bestProductMobileElectonicProducts!
          .map((v) => v.toJson())
          .toList();
    }
    if (jewellery != null) {
      data['Jewellery'] = jewellery!.map((v) => v.toJson()).toList();
    }
    if (furniture != null) {
      data['Furniture'] = furniture!.map((v) => v.toJson()).toList();
    }
    if (topRatingStore != null) {
      data['top_rating_store'] =
          topRatingStore!.map((v) => v.toJson()).toList();
    }
    if (topHomeKitchenProducts != null) {
      data['top_home_kitchen_products'] =
          topHomeKitchenProducts!.map((v) => v.toJson()).toList();
    }
    if (famousStore != null) {
      data['famous_store'] = famousStore!.map((v) => v.toJson()).toList();
    }
    if (rentals != null) {
      data['rentals'] = rentals!.map((v) => v.toJson()).toList();
    }
    if (topHealthProducts != null) {
      data['top_health_products'] =
          topHealthProducts!.map((v) => v.toJson()).toList();
    }
    if (adsBannerMiddle2 != null) {
      data['ads_banner_middle2'] =
          adsBannerMiddle2!.map((v) => v.toJson()).toList();
    }
    if (adsBannerBottom != null) {
      data['ads_banner_bottom'] =
          adsBannerBottom!.map((v) => v.toJson()).toList();
    }
    if (recentSearches != null) {
      data['recent_searches'] =
          recentSearches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestProductMobileElectonicProducts {
  String? createdBy;
  String? productId;
  String? productTitle;
  String? productSlug;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productImage;
  bool? cashbackTag;
  String? cashbackText;
  String? storeSlug;
  String? contactNo;
  String? shareLink;
  String? whatsapptext;
  String? wantToBuy;

  BestProductMobileElectonicProducts(
      {this.createdBy,
        this.productId,
        this.productTitle,
        this.productSlug,
        this.productCategory,
        this.price,
        this.offerPrice,
        this.storeName,
        this.productImage,
        this.cashbackTag,
        this.cashbackText,
        this.storeSlug,
        this.contactNo,
        this.shareLink,
        this.whatsapptext,
        this.wantToBuy});

  BestProductMobileElectonicProducts.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offer_price'];
    storeName = json['store_name'];
    productImage = json['product_image'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    shareLink = json['share_link'];
    whatsapptext = json['whatsapptext'];
    wantToBuy = json['want_to_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['product_category'] = productCategory;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['store_name'] = storeName;
    data['product_image'] = productImage;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}


class Jewellery {
  Jewellery({
    this.createdBy,
    this.productId,
    this.productTitle,
    this.productSlug,
    this.productCategory,
    this.price,
    this.offerPrice,
    this.storeName,
    this.productImage,
    this.cashbackTag,
    this.cashbackText,
    this.storeSlug,
    this.contactNo,
    this.shareLink,
    this.whatsapptext,
    this.wantToBuy,
  });
  String? createdBy;
  String? productId;
  String? productTitle;
  String? productSlug;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productImage;
  bool? cashbackTag;
  String? cashbackText;
  String? storeSlug;
  String? contactNo;
  String? shareLink;
  String? whatsapptext;
  String? wantToBuy;

  Jewellery.fromJson(Map<String, dynamic> json){
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offer_price'];
    storeName = json['store_name'];
    productImage = json['product_image'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    shareLink = json['share_link'];
    whatsapptext = json['whatsapptext'];
    wantToBuy = json['want_to_buy'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['product_category'] = productCategory;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['store_name'] = storeName;
    data['product_image'] = productImage;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}

class Furniture {
  Furniture({
    this.createdBy,
    this.productId,
    this.productTitle,
    this.productSlug,
    this.productCategory,
    this.price,
    this.offerPrice,
    this.storeName,
    this.productImage,
    this.cashbackTag,
    this.cashbackText,
    this.storeSlug,
    this.contactNo,
    this.shareLink,
    this.whatsapptext,
    this.wantToBuy,
  });
  String? createdBy;
  String? productId;
  String? productTitle;
  String? productSlug;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productImage;
  bool? cashbackTag;
  String? cashbackText;
  String? storeSlug;
  String? contactNo;
  String? shareLink;
  String? whatsapptext;
  String? wantToBuy;

  Furniture.fromJson(Map<String, dynamic> json){
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offerPrice'];
    // offerPrice = null;
    storeName = json['store_name'];
    productImage = json['product_image'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    shareLink = json['share_link'];
    whatsapptext = json['whatsapptext'];
    wantToBuy = json['want_to_buy'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['product_category'] = productCategory;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['store_name'] = storeName;
    data['product_image'] = productImage;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}


class TopRatingStore {
  String? sellerId;
  String? contactNo;
  String? address;
  String? name;
  String? storeSlug;
  String? shopImage;
  String? ratingNumber;
  String? distanceKm;
  bool? cashbackTag;
  String? cashbackText;
  String? shareLink;
  String? whatsapptext;
  String? wantToBuy;

  TopRatingStore(
      {this.sellerId,
        this.contactNo,
        this.address,
        this.name,
        this.storeSlug,
        this.shopImage,
        this.ratingNumber,
        this.distanceKm,
        this.cashbackTag,
        this.cashbackText,
        this.shareLink,
        this.whatsapptext,
        this.wantToBuy});

  TopRatingStore.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    contactNo = json['contact_no'];
    address = json['address'];
    name = json['name'];
    storeSlug = json['store_slug'];
    shopImage = json['shop_image'];
    ratingNumber = json['rating_number'];
    distanceKm = json['distance_km'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
    shareLink = json['share_link'];
    whatsapptext = json['whatsapptext'];
    wantToBuy = json['want_to_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['contact_no'] = contactNo;
    data['address'] = address;
    data['name'] = name;
    data['store_slug'] = storeSlug;
    data['shop_image'] = shopImage;
    data['rating_number'] = ratingNumber;
    data['distance_km'] = distanceKm;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}

class FamousStore {
  String? sellerId;
  String? storeSlug;
  String? userId;
  String? name;
  String? shopImage;
  String? rating;
  bool? cashbackTag;
  String? cashbackText;

  FamousStore(
      {this.sellerId,
        this.storeSlug,
        this.userId,
        this.name,
        this.shopImage,
        this.rating,
        this.cashbackTag,
        this.cashbackText});

  FamousStore.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    storeSlug = json['store_slug'];
    userId = json['user_id'];
    name = json['name'];
    shopImage = json['shop_image'];
    rating = json['rating'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['store_slug'] = storeSlug;
    data['user_id'] = userId;
    data['name'] = name;
    data['shop_image'] = shopImage;
    data['rating'] = rating;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}

class Rentals {
  String? rentTitle;
  String? keyword;
  String? rentImage;

  Rentals({this.rentTitle, this.keyword, this.rentImage});

  Rentals.fromJson(Map<String, dynamic> json) {
    rentTitle = json['rent_title'];
    keyword = json['keyword'];
    rentImage = json['rent_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rent_title'] = rentTitle;
    data['keyword'] = keyword;
    data['rent_image'] = rentImage;
    return data;
  }
}

class TopHealthProducts {
  String? createdBy;
  String? productId;
  String? productTitle;
  String? productSlug;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productImage;
  bool? cashbackTag;
  String? cashbackText;

  TopHealthProducts(
      {this.createdBy,
        this.productId,
        this.productTitle,
        this.productSlug,
        this.productCategory,
        this.price,
        this.offerPrice,
        this.storeName,
        this.productImage,
        this.cashbackTag,
        this.cashbackText});

  TopHealthProducts.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offer_price'];
    storeName = json['store_name'];
    productImage = json['product_image'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['product_category'] = productCategory;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['store_name'] = storeName;
    data['product_image'] = productImage;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}

class AdsBannerMiddle2 {
  String? bannerImage;
  String? type;
  String? whatsapptext;
  String? keyword;
  String? bannerTitle;
  String? discount;

  AdsBannerMiddle2(
      {this.bannerImage,
        this.type,
        this.whatsapptext,
        this.keyword,
        this.bannerTitle,
        this.discount});

  AdsBannerMiddle2.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
    type = json['type'];
    whatsapptext = json['whatsapptext'];
    keyword = json['keyword'];
    bannerTitle = json['banner_title'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_image'] = bannerImage;
    data['type'] = type;
    data['whatsapptext'] = whatsapptext;
    data['keyword'] = keyword;
    data['banner_title'] = bannerTitle;
    data['discount'] = discount;
    return data;
  }
}


class TopHomeKitchenProducts {
  TopHomeKitchenProducts({
    this.createdBy,
    this.productId,
    this.productTitle,
    this.productSlug,
    this.productCategory,
    this.price,
    this.offerPrice,
    this.storeName,
    this.productImage,
    this.cashbackTag,
    this.cashbackText,
    this.storeSlug,
    this.contactNo,
    this.shareLink,
    this.whatsapptext,
    this.wantToBuy,
  });
  String? createdBy;
  String? productId;
  String? productTitle;
  String? productSlug;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productImage;
  bool? cashbackTag;
  String? cashbackText;
  String? storeSlug;
  String? contactNo;
  String? shareLink;
  String? whatsapptext;
  String? wantToBuy;

  TopHomeKitchenProducts.fromJson(Map<String, dynamic> json){
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offer_price'];
    storeName = json['store_name'];
    productImage = json['product_image'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    shareLink = json['share_link'];
    whatsapptext = json['whatsapptext'];
    wantToBuy = json['want_to_buy'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['product_category'] = productCategory;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['store_name'] = storeName;
    data['product_image'] = productImage;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}


class AdsBannerBottom {
  AdsBannerBottom({
    this.bannerImage,
    this.type,
    this.whatsapptext,
    this.keyword,
    this.bannerTitle,
    this.discount,
  });
  String? bannerImage;
  String? type;
  String? whatsapptext;
  String? keyword;
  String? bannerTitle;
  dynamic discount;

  AdsBannerBottom.fromJson(Map<String, dynamic> json){
    bannerImage = json['banner_image'];
    type = json['type'];
    whatsapptext = json['whatsapptext'];
    // whatsapptext = null;
    keyword = json['keyword'];
    bannerTitle = json['banner_title'];
    discount = json['discount'];
    // discount = null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['banner_image'] = bannerImage;
    data['type'] = type;
    data['whatsapptext'] = whatsapptext;
    data['keyword'] = keyword;
    data['banner_title'] = bannerTitle;
    data['discount'] = discount;
    return data;
  }
}



class RecentSearches {
  String? dataId;
  String? rsTitle;
  String? rcImage;
  bool? isLoading;
  String? searchDate;
  String? dataType;
  bool? cashbackTag;
  String? cashbackText;

  RecentSearches(
      {this.dataId,
        this.rsTitle,
        this.rcImage,
        this.searchDate,
        this.dataType,
        this.cashbackTag,
        this.cashbackText});

  RecentSearches.fromJson(Map<String, dynamic> json) {
    dataId = json['data_id'];
    rsTitle = json['rs_title'];
    rcImage = json['rc_image'];
    searchDate = json['search_date'];
    dataType = json['data_type'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_id'] = dataId;
    data['rs_title'] = rsTitle;
    data['rc_image'] = rcImage;
    data['search_date'] = searchDate;
    data['data_type'] = dataType;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}
