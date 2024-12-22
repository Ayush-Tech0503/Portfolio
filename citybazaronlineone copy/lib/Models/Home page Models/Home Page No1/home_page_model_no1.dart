class Homepage1Data {
  Homepage1Data({
    this.status,
    this.dataCount,
    this.data,
  });
  String? status;
  int? dataCount;
  DataHome? data;

  Homepage1Data.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        dataCount = json['data_count'],
        data = DataHome.fromJson(json['data']);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data_count'] = dataCount;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class DataHome {
  DataHome({
    this.topBanners,
    this.topOffers,
    this.icons,
    this.topProductsFashionAccessoriesProducts,
    this.famousMarket,
    this.discountZone,
    this.adsBannerMiddle,
    this.headingText,
    this.appLinks,
    this.defaultLocation,
    this.topProducMen,
    this.topProducWomen,
    this.topProducKids,
    this.topProducFootwear,
    this.topProducMobile,
    this.topProducMobileAccessories,
    this.topProducHomeAppliance,
    this.topProducComputerAccessories,
    this.topProducFashionAccessories,
    this.topProducEyeWearandcare,
    this.topProducHomeDecor,
    this.topProducBagsAndLuggage,
    this.topProducBeauty,
    this.topProducFoodDrinks,
    this.topProducAutomotive,
    this.topProducfinishingMaterial,
    this.topSeller,
  });
  List<TopBanners>? topBanners;
  List<TopOffers>? topOffers;
  List<IconsData>? icons;
  List<TopProductsFashionAccessoriesProducts>?
  topProductsFashionAccessoriesProducts;
  List<FamousMarket>? famousMarket;
  List<DiscountZone>? discountZone;
  List<AdsBannerMiddle>? adsBannerMiddle;
  String? headingText;
  AppLinks? appLinks;
  DefaultLocation? defaultLocation;
  List<TopProducMen>? topProducMen;
  List<TopProducWomen>? topProducWomen;
  List<TopProducKids>? topProducKids;
  List<TopProducFootwear>? topProducFootwear;
  List<TopProducMobile>? topProducMobile;
  List<TopProducMobileAccessories>? topProducMobileAccessories;
  List<TopProducHomeAppliance>? topProducHomeAppliance;
  List<TopProducComputerAccessories>? topProducComputerAccessories;
  List<TopProducFashionAccessories>? topProducFashionAccessories;
  List<TopProducEyeWearandcare>? topProducEyeWearandcare;
  List<dynamic>? topProducHomeDecor;
  List<TopProducBagsAndLuggage>? topProducBagsAndLuggage;
  List<dynamic>? topProducBeauty;
  List<dynamic>? topProducFoodDrinks;
  List<dynamic>? topProducAutomotive;
  List<TopProducfinishingMaterial>? topProducfinishingMaterial;
  List<dynamic>? topSeller;

  DataHome.fromJson(Map<String, dynamic> json)
      : topBanners = (json['top_banners'] as List<dynamic>?)
      ?.map((e) => TopBanners.fromJson(e))
      .toList(),
        topOffers = (json['top_offers'] as List<dynamic>?)
            ?.map((e) => TopOffers.fromJson(e))
            .toList(),
        icons = (json['icons'] as List<dynamic>?)
            ?.map((e) => IconsData.fromJson(e))
            .toList(),
        topProductsFashionAccessoriesProducts = (json[
        'top_products_fashion_accessories_products']
        as List<dynamic>?)
            ?.map((e) => TopProductsFashionAccessoriesProducts.fromJson(e))
            .toList(),
        famousMarket = (json['famous_market'] as List<dynamic>?)
            ?.map((e) => FamousMarket.fromJson(e))
            .toList(),
        discountZone = (json['discount_zone'] as List<dynamic>?)
            ?.map((e) => DiscountZone.fromJson(e))
            .toList(),
        adsBannerMiddle = (json['ads_banner_middle'] as List<dynamic>?)
            ?.map((e) => AdsBannerMiddle.fromJson(e))
            .toList(),
        headingText = json['heading_text'],
        appLinks = AppLinks.fromJson(json['app_links']),
        defaultLocation = DefaultLocation.fromJson(json['default_location']),
        topProducMen = (json['topProducMen'] as List<dynamic>?)
            ?.map((e) => TopProducMen.fromJson(e))
            .toList(),
        topProducWomen = (json['topProducWomen'] as List<dynamic>?)
            ?.map((e) => TopProducWomen.fromJson(e))
            .toList(),
        topProducKids = (json['topProducKids'] as List<dynamic>?)
            ?.map((e) => TopProducKids.fromJson(e))
            .toList(),
        topProducFootwear = (json['topProducFootwear'] as List<dynamic>?)
            ?.map((e) => TopProducFootwear.fromJson(e))
            .toList(),
        topProducMobile = (json['topProducMobile'] as List<dynamic>?)
            ?.map((e) => TopProducMobile.fromJson(e))
            .toList(),
        topProducMobileAccessories = (json['topProducMobileAccessories']
        as List<dynamic>?)
            ?.map((e) => TopProducMobileAccessories.fromJson(e))
            .toList(),
        topProducHomeAppliance = (json['topProducHomeAppliance']
        as List<dynamic>?)
            ?.map((e) => TopProducHomeAppliance.fromJson(e))
            .toList(),
        topProducComputerAccessories = (json['topProducComputerAccessories']
        as List<dynamic>?)
            ?.map((e) => TopProducComputerAccessories.fromJson(e))
            .toList(),
        topProducFashionAccessories = (json['topProducFashionAccessories']
        as List<dynamic>?)
            ?.map((e) => TopProducFashionAccessories.fromJson(e))
            .toList(),
        topProducEyeWearandcare = (json['topProducEyeWearandcare']
        as List<dynamic>?)
            ?.map((e) => TopProducEyeWearandcare.fromJson(e))
            .toList(),
        topProducHomeDecor = json['topProducHomeDecor'],
        topProducBagsAndLuggage = (json['topProducBagsAndLuggage']
        as List<dynamic>?)
            ?.map((e) => TopProducBagsAndLuggage.fromJson(e))
            .toList(),
        topProducBeauty = json['topProducBeauty'],
        topProducFoodDrinks = json['topProducFoodDrinks'],
        topProducAutomotive = json['topProducAutomotive'],
        topProducfinishingMaterial = (json['topProducfinishingMaterial']
        as List<dynamic>?)
            ?.map((e) => TopProducfinishingMaterial.fromJson(e))
            .toList(),
        topSeller = json['top_seller'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['top_banners'] = topBanners?.map((e) => e.toJson()).toList();
    _data['top_offers'] = topOffers?.map((e) => e.toJson()).toList();
    _data['icons'] = icons?.map((e) => e.toJson()).toList();
    _data['top_products_fashion_accessories_products'] =
        topProductsFashionAccessoriesProducts
            ?.map((e) => e.toJson())
            .toList();
    _data['famous_market'] = famousMarket?.map((e) => e.toJson()).toList();
    _data['discount_zone'] = discountZone?.map((e) => e.toJson()).toList();
    _data['ads_banner_middle'] =
        adsBannerMiddle?.map((e) => e.toJson()).toList();
    _data['heading_text'] = headingText;
    _data['app_links'] = appLinks?.toJson();
    _data['default_location'] = defaultLocation?.toJson();
    _data['topProducMen'] = topProducMen?.map((e) => e.toJson()).toList();
    _data['topProducWomen'] = topProducWomen?.map((e) => e.toJson()).toList();
    _data['topProducKids'] = topProducKids?.map((e) => e.toJson()).toList();
    _data['topProducFootwear'] =
        topProducFootwear?.map((e) => e.toJson()).toList();
    _data['topProducMobile'] = topProducMobile?.map((e) => e.toJson()).toList();
    _data['topProducMobileAccessories'] =
        topProducMobileAccessories?.map((e) => e.toJson()).toList();
    _data['topProducHomeAppliance'] =
        topProducHomeAppliance?.map((e) => e.toJson()).toList();
    _data['topProducComputerAccessories'] =
        topProducComputerAccessories?.map((e) => e.toJson()).toList();
    _data['topProducFashionAccessories'] =
        topProducFashionAccessories?.map((e) => e.toJson()).toList();
    _data['topProducEyeWearandcare'] =
        topProducEyeWearandcare?.map((e) => e.toJson()).toList();
    _data['topProducHomeDecor'] = topProducHomeDecor;
    _data['topProducBagsAndLuggage'] =
        topProducBagsAndLuggage?.map((e) => e.toJson()).toList();
    _data['topProducBeauty'] = topProducBeauty;
    _data['topProducFoodDrinks'] = topProducFoodDrinks;
    _data['topProducAutomotive'] = topProducAutomotive;
    _data['topProducfinishingMaterial'] =
        topProducfinishingMaterial?.map((e) => e.toJson()).toList();
    _data['top_seller'] = topSeller;
    return _data;
  }
}
class TopBanners {
  TopBanners({
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
  String? discount;

  TopBanners.fromJson(Map<String, dynamic> json){
    bannerImage = json['banner_image'];
    type = json['type'];
    whatsapptext = json["whatsapptext"];
    keyword = json["keyword"];
    bannerTitle = json['banner_title'];
    discount = json["discount"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banner_image'] = bannerImage;
    _data['type'] = type;
    _data['whatsapptext'] = whatsapptext;
    _data['keyword'] = keyword;
    _data['banner_title'] = bannerTitle;
    _data['discount'] = discount;
    return _data;
  }
}
class TopOffers {
  TopOffers({
    this.offerTitle,
    this.offerImage,
    this.offerId,
    this.offerUrl,
    this.offerStatus,
  });
  String? offerTitle;
  String? offerImage;
  String? offerId;
  String? offerUrl;
  String? offerStatus;

  TopOffers.fromJson(Map<String, dynamic> json)
      : offerTitle = json['offer_title'],
       offerImage = json['offer_image'],
        offerId = json['offer_id'],
        offerUrl = json['offer_url'],
        offerStatus = json['offer_status'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offer_title'] = offerTitle;
    _data['offer_image'] = offerImage;
    _data['offer_id'] = offerId;
    _data['offer_url'] = offerUrl;
    _data['offer_status'] = offerStatus;
    return _data;
  }
}

class IconsData {
  IconsData({
    this.iconTitle,
    this.iconImage,
    this.iconId,
    this.iconUrl,
    this.iconStatus,
  });
  String? iconTitle;
  String? iconImage;
  String? iconId;
  String? iconUrl;
  String? iconStatus;

  IconsData.fromJson(Map<String, dynamic> json)
      : iconTitle = json['icon_title'],
       iconImage = json['icon_image'],
        iconId = json['icon_id'],
        iconUrl = json['icon_url'],
        iconStatus = json['icon_status'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['icon_image'] = iconTitle;
    _data['icon_title'] = iconImage;
    _data['icon_id'] = iconId;
    _data['icon_url'] = iconUrl;
    _data['icon_status'] = iconStatus;
    return _data;
  }
}

class TopProductsFashionAccessoriesProducts {
  TopProductsFashionAccessoriesProducts({
    this.productImage,
    this.productTitle,
    this.productCategory,
    this.price,
    this.offerPrice,
    this.storeName,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productTitle;
  String? productCategory;
  String? price;
  String? offerPrice;
  String? storeName;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProductsFashionAccessoriesProducts.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
       productTitle = json['product_title'],
        productCategory = json['product_category'],
        price = json['price'],
        offerPrice = json['offer_price'],
        storeName = json['store_name'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_title'] = productTitle;
    _data['product_category'] = productCategory;
    _data['price'] = price;
    _data['offer_price'] = offerPrice;
    _data['store_name'] = storeName;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class FamousMarket {
  FamousMarket({
      this.fmId,
      this.fmName,
      this.location,
      this.city,
      this.imageUrl,
  });

     String? fmId;
   String? fmName;
   String? location;
   String? city;
   String? imageUrl;

  factory FamousMarket.fromJson(Map<String, dynamic> json) {
    return FamousMarket(
      fmId: json['fm_id'] as String? ?? '', // Provide a default value, such as an empty string
      fmName: json['fm_name'] as String? ?? '',
      location: json['location'] as String? ?? '',
      city: json['city'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fm_id'] = fmId;
    _data['fm_name'] = fmName;
    _data['location'] = location;
    _data['city'] = city;
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class DiscountZone {
  DiscountZone({
      this.name,
      this.minPrice,
      this.maxPrice,
      this.image,
  });
   String? name;
   int? minPrice;
   int? maxPrice;
  String? image;

  DiscountZone.fromJson(Map<String, dynamic> json){
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['image'] = image;
    return data;
  }
}

// class DiscountZone {
//   DiscountZone({
//      this.name,
//    this.minPrice,
//     this.maxPrice,
//    this.image,
//   });
//   String? name;
//   String? minPrice;
//   String? maxPrice;
//   String? image;
//
//   DiscountZone.fromJson(Map<String, dynamic> json)
//       : name = json['name'];
//   minPrice = json['min_price'];
//   maxPrice = json['max_price'];
//   image = json['image'];
//         discountImage = json['name'],
//         discountId = json['discount_id'],
//         discountName = json['discount_name'],
//         discountStatus = json['discount_status'];
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['min_price'] = minPrice;
//     _data['max_price'] = maxPrice;
//     _data['image'] = image;
//     // _data['discount_image'] = discountImage;
//     // _data['discount_id'] = discountId;
//     // _data['discount_name'] = discountName;
//     // _data['discount_status'] = discountStatus;
//     return _data;
//   }
// }


class AdsBannerMiddle {
  AdsBannerMiddle({
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
  String? discount;

  AdsBannerMiddle.fromJson(Map<String, dynamic> json){
    bannerImage = json['banner_image'];
    type = json['type'];
    whatsapptext = json["whatsapptext"];
    keyword = json["keyword"];
    bannerTitle = json['banner_title'];
    discount = json["discount"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banner_image'] = bannerImage;
    _data['type'] = type;
    _data['whatsapptext'] = whatsapptext;
    _data['keyword'] = keyword;
    _data['banner_title'] = bannerTitle;
    _data['discount'] = discount;
    return _data;
  }
}

class AppLinks {
  AppLinks({
    this.websiteUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });
  String? websiteUrl;
  String? playStoreUrl;
  String? appStoreUrl;

  AppLinks.fromJson(Map<String, dynamic> json)
      : websiteUrl = json['website_url'],
        playStoreUrl = json['play_store_url'],
        appStoreUrl = json['app_store_url'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['website_url'] = websiteUrl;
    _data['play_store_url'] = playStoreUrl;
    _data['app_store_url'] = appStoreUrl;
    return _data;
  }
}

class DefaultLocation {
  DefaultLocation({
    this.countryName,
    this.countryCode,
  });
  String? countryName;
  String? countryCode;

  DefaultLocation.fromJson(Map<String, dynamic> json)
      : countryName = json['country_name'],
        countryCode = json['country_code'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country_name'] = countryName;
    _data['country_code'] = countryCode;
    return _data;
  }
}

class TopProducMen {
  TopProducMen({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducMen.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducWomen {
  TopProducWomen({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducWomen.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducKids {
  TopProducKids({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducKids.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducFootwear {
  TopProducFootwear({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducFootwear.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducMobile {
  TopProducMobile({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducMobile.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducMobileAccessories {
  TopProducMobileAccessories({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducMobileAccessories.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducHomeAppliance {
  TopProducHomeAppliance({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducHomeAppliance.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducComputerAccessories {
  TopProducComputerAccessories({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducComputerAccessories.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducFashionAccessories {
  TopProducFashionAccessories({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducFashionAccessories.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducEyeWearandcare {
  TopProducEyeWearandcare({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducEyeWearandcare.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducBagsAndLuggage {
  TopProducBagsAndLuggage({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducBagsAndLuggage.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class TopProducfinishingMaterial {
  TopProducfinishingMaterial({
    this.productImage,
    this.productId,
    this.productName,
    this.productStatus,
    this.productPrice,
  });
  String? productImage;
  String? productId;
  String? productName;
  String? productStatus;
  String? productPrice;

  TopProducfinishingMaterial.fromJson(Map<String, dynamic> json)
      : productImage = json['product_image'],
        productId = json['product_id'],
        productName = json['product_name'],
        productStatus = json['product_status'],
        productPrice = json['product_price'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_image'] = productImage;
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['product_status'] = productStatus;
    _data['product_price'] = productPrice;
    return _data;
  }
}


// class Homepage1Data {
//   Homepage1Data({
//     required this.status,
//     required this.dataCount,
//     required this.data,
//   });
//   late final String status;
//   late final int dataCount;
//   late final DataHome data;
//
//   Homepage1Data.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     dataCount = json['data_count'];
//     data = DataHome.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['data_count'] = dataCount;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class DataHome {
//   DataHome({
//     required this.topBanners,
//     required this.adsBannerMiddle,
//     required this.topOffers,
//     required this.icons,
//     required this.topProductsFashionAccessoriesProducts,
//     required this.famousMarket,
//     required this.discountZone,
//     required this.headingText,
//     required this.appLinks,
//     required this.defaultLocation,
//     required this.topProducMen,
//     required this.topProducWomen,
//     required this.topProducKids,
//     required this.topProducFootwear,
//     required this.topProducMobile,
//     required this.topProducMobileAccessories,
//     required this.topProducHomeAppliance,
//     required this.topProducComputerAccessories,
//     required this.topProducFashionAccessories,
//     required this.topProducEyeWearandcare,
//     required this.topProducHomeDecor,
//     required this.topProducBagsAndLuggage,
//     required this.topProducBeauty,
//     required this.topProducFoodDrinks,
//     required this.topProducAutomotive,
//     required this.topProducfinishingMaterial,
//     required this.topSeller,
//   });
//   late final List<TopBanners> topBanners;
//   late final List<AdsBannerMiddle> adsBannerMiddle;
//   late final List<TopOffers> topOffers;
//   late final List<IconsData> icons;
//   late final List<TopProductsFashionAccessoriesProducts> topProductsFashionAccessoriesProducts;
//   late final List<FamousMarket> famousMarket;
//   late final List<DiscountZone> discountZone;
//   late final String headingText;
//   late final AppLinks appLinks;
//   late final DefaultLocation defaultLocation;
//   late final List<TopProducMen> topProducMen;
//   late final List<TopProducWomen> topProducWomen;
//   late final List<dynamic> topProducKids;
//   late final List<TopProducFootwear> topProducFootwear;
//   late final List<TopProducMobile> topProducMobile;
//   late final List<TopProducMobileAccessories> topProducMobileAccessories;
//   late final List<TopProducHomeAppliance> topProducHomeAppliance;
//   late final List<TopProducComputerAccessories> topProducComputerAccessories;
//   late final List<TopProducFashionAccessories> topProducFashionAccessories;
//   late final List<TopProducEyeWearandcare> topProducEyeWearandcare;
//   late final List<TopProducHomeDecor> topProducHomeDecor;
//   late final List<TopProducBagsAndLuggage> topProducBagsAndLuggage;
//   late final List<TopProducBeauty> topProducBeauty;
//   late final List<TopProducFoodDrinks> topProducFoodDrinks;
//   late final List<TopProducAutomotive> topProducAutomotive;
//   late final List<TopProducfinishingMaterial> topProducfinishingMaterial;
//   late final List<dynamic> topSeller;
//
//   DataHome.fromJson(Map<String, dynamic> json){
//     topBanners = List.from(json['top_banners']).map((e)=>TopBanners.fromJson(e)).toList();
//     adsBannerMiddle = List.from(json['ads_banner_middle']).map((e)=>AdsBannerMiddle.fromJson(e)).toList();
//     topOffers = List.from(json['top_offers']).map((e)=>TopOffers.fromJson(e)).toList();
//     icons = List.from(json['icons']).map((e)=>IconsData.fromJson(e)).toList();
//     topProductsFashionAccessoriesProducts = List.from(json['top_products_fashion_accessories_products']).map((e)=>TopProductsFashionAccessoriesProducts.fromJson(e)).toList();
//     famousMarket = List.from(json['famous_market']).map((e)=>FamousMarket.fromJson(e)).toList();
//     discountZone = List.from(json['discount_zone']).map((e)=>DiscountZone.fromJson(e)).toList();
//     headingText = json['heading_text'];
//     appLinks = AppLinks.fromJson(json['app_links']);
//     defaultLocation = DefaultLocation.fromJson(json['default_location']);
//     topProducMen = List.from(json['topProducMen']).map((e)=>TopProducMen.fromJson(e)).toList();
//     topProducWomen = List.from(json['topProducWomen']).map((e)=>TopProducWomen.fromJson(e)).toList();
//     topProducKids = List.castFrom<dynamic, dynamic>(json['topProducKids']);
//     topProducFootwear = List.from(json['topProducFootwear']).map((e)=>TopProducFootwear.fromJson(e)).toList();
//     topProducMobile = List.from(json['topProducMobile']).map((e)=>TopProducMobile.fromJson(e)).toList();
//     topProducMobileAccessories = List.from(json['topProducMobileAccessories']).map((e)=>TopProducMobileAccessories.fromJson(e)).toList();
//     topProducHomeAppliance = List.from(json['topProducHomeAppliance']).map((e)=>TopProducHomeAppliance.fromJson(e)).toList();
//     topProducComputerAccessories = List.from(json['topProducComputerAccessories']).map((e)=>TopProducComputerAccessories.fromJson(e)).toList();
//     topProducFashionAccessories = List.from(json['topProducFashionAccessories']).map((e)=>TopProducFashionAccessories.fromJson(e)).toList();
//     topProducEyeWearandcare = List.from(json['topProducEyeWearandcare']).map((e)=>TopProducEyeWearandcare.fromJson(e)).toList();
//     topProducHomeDecor = List.from(json['topProducHomeDecor']).map((e)=>TopProducHomeDecor.fromJson(e)).toList();
//     topProducBagsAndLuggage = List.from(json['topProducBagsAndLuggage']).map((e)=>TopProducBagsAndLuggage.fromJson(e)).toList();
//     topProducBeauty = List.from(json['topProducBeauty']).map((e)=>TopProducBeauty.fromJson(e)).toList();
//     topProducFoodDrinks = List.from(json['topProducFoodDrinks']).map((e)=>TopProducFoodDrinks.fromJson(e)).toList();
//     topProducAutomotive = List.from(json['topProducAutomotive']).map((e)=>TopProducAutomotive.fromJson(e)).toList();
//     topProducfinishingMaterial = List.from(json['topProducfinishingMaterial']).map((e)=>TopProducfinishingMaterial.fromJson(e)).toList();
//     topSeller = List.castFrom<dynamic, dynamic>(json['top_seller']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['top_banners'] = topBanners.map((e)=>e.toJson()).toList();
//     _data['ads_banner_middle'] = adsBannerMiddle.map((e)=>e.toJson()).toList();
//     _data['top_offers'] = topOffers.map((e)=>e.toJson()).toList();
//     _data['icons'] = icons.map((e)=>e.toJson()).toList();
//     _data['top_products_fashion_accessories_products'] = topProductsFashionAccessoriesProducts.map((e)=>e.toJson()).toList();
//     _data['famous_market'] = famousMarket.map((e)=>e.toJson()).toList();
//     _data['discount_zone'] = discountZone.map((e)=>e.toJson()).toList();
//     _data['heading_text'] = headingText;
//     _data['app_links'] = appLinks.toJson();
//     _data['default_location'] = defaultLocation.toJson();
//     _data['topProducMen'] = topProducMen.map((e)=>e.toJson()).toList();
//     _data['topProducWomen'] = topProducWomen.map((e)=>e.toJson()).toList();
//     _data['topProducKids'] = topProducKids;
//     _data['topProducFootwear'] = topProducFootwear.map((e)=>e.toJson()).toList();
//     _data['topProducMobile'] = topProducMobile.map((e)=>e.toJson()).toList();
//     _data['topProducMobileAccessories'] = topProducMobileAccessories.map((e)=>e.toJson()).toList();
//     _data['topProducHomeAppliance'] = topProducHomeAppliance.map((e)=>e.toJson()).toList();
//     _data['topProducComputerAccessories'] = topProducComputerAccessories.map((e)=>e.toJson()).toList();
//     _data['topProducFashionAccessories'] = topProducFashionAccessories.map((e)=>e.toJson()).toList();
//     _data['topProducEyeWearandcare'] = topProducEyeWearandcare.map((e)=>e.toJson()).toList();
//     _data['topProducHomeDecor'] = topProducHomeDecor.map((e)=>e.toJson()).toList();
//     _data['topProducBagsAndLuggage'] = topProducBagsAndLuggage.map((e)=>e.toJson()).toList();
//     _data['topProducBeauty'] = topProducBeauty.map((e)=>e.toJson()).toList();
//     _data['topProducFoodDrinks'] = topProducFoodDrinks.map((e)=>e.toJson()).toList();
//     _data['topProducAutomotive'] = topProducAutomotive.map((e)=>e.toJson()).toList();
//     _data['topProducfinishingMaterial'] = topProducfinishingMaterial.map((e)=>e.toJson()).toList();
//     _data['top_seller'] = topSeller;
//     return _data;
//   }
// }
//
// class TopBanners {
//   TopBanners({
//     required this.bannerImage,
//     required this.type,
//     this.whatsapptext,
//     required this.keyword,
//     required this.bannerTitle,
//     this.discount,
//   });
//   late final String bannerImage;
//   late final String type;
//   late final Null whatsapptext;
//   late final String keyword;
//   late final String bannerTitle;
//   late final Null discount;
//
//   TopBanners.fromJson(Map<String, dynamic> json){
//     bannerImage = json['banner_image'];
//     type = json['type'];
//     whatsapptext = null;
//     keyword = json['keyword'];
//     bannerTitle = json['banner_title'];
//     discount = null;
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
// class AdsBannerMiddle {
//   AdsBannerMiddle({
//     required this.bannerImage,
//     required this.type,
//     this.whatsapptext,
//     required this.keyword,
//     required this.bannerTitle,
//     this.discount,
//   });
//   late final String bannerImage;
//   late final String type;
//   late final Null whatsapptext;
//   late final String keyword;
//   late final String bannerTitle;
//   late final String? discount;
//
//   AdsBannerMiddle.fromJson(Map<String, dynamic> json){
//     bannerImage = json['banner_image'];
//     type = json['type'];
//     whatsapptext = null;
//     keyword = json['keyword'];
//     bannerTitle = json['banner_title'];
//     discount = null;
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
// class TopOffers {
//   TopOffers({
//     required this.offerTitle,
//     required this.offerImage,
//   });
//   late final String offerTitle;
//   late final String offerImage;
//
//   TopOffers.fromJson(Map<String, dynamic> json){
//     offerTitle = json['offer_title'];
//     offerImage = json['offer_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['offer_title'] = offerTitle;
//     _data['offer_image'] = offerImage;
//     return _data;
//   }
// }
//
// class IconsData {
//   IconsData({
//     required this.iconTitle,
//     required this.iconImage,
//   });
//   late final String iconTitle;
//   late final String iconImage;
//
//   IconsData.fromJson(Map<String, dynamic> json){
//     iconTitle = json['icon_title'];
//     iconImage = json['icon_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['icon_title'] = iconTitle;
//     _data['icon_image'] = iconImage;
//     return _data;
//   }
// }
//
// class TopProductsFashionAccessoriesProducts {
//   TopProductsFashionAccessoriesProducts({
//     required this.createdBy,
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.price,
//     this.offerPrice,
//     required this.storeName,
//     required this.productImage,
//     required this.cashbackTag,
//     required this.cashbackText,
//   });
//   late final String createdBy;
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String price;
//   late final String? offerPrice;
//   late final String storeName;
//   late final String productImage;
//   late final bool cashbackTag;
//   late final String cashbackText;
//
//   TopProductsFashionAccessoriesProducts.fromJson(Map<String, dynamic> json){
//     createdBy = json['created_by'];
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     price = json['price'];
//     offerPrice = null;
//     storeName = json['store_name'];
//     productImage = json['product_image'];
//     cashbackTag = json['cashback_tag'];
//     cashbackText = json['cashback_text'];
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
//     return _data;
//   }
// }
//
// class FamousMarket {
//   FamousMarket({
//     required this.fmId,
//     required this.fmName,
//     required this.location,
//     required this.city,
//     required this.imageUrl,
//   });
//   late final String fmId;
//   late final String fmName;
//   late final String location;
//   late final String city;
//   late final String imageUrl;
//
//   FamousMarket.fromJson(Map<String, dynamic> json){
//     fmId = json['fm_id'];
//     fmName = json['fm_name'];
//     location = json['location'];
//     city = json['city'];
//     imageUrl = json['image_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['fm_id'] = fmId;
//     _data['fm_name'] = fmName;
//     _data['location'] = location;
//     _data['city'] = city;
//     _data['image_url'] = imageUrl;
//     return _data;
//   }
// }
//
// class DiscountZone {
//   DiscountZone({
//     required this.name,
//     required this.minPrice,
//     required this.maxPrice,
//     required this.image,
//   });
//   late final String name;
//   late final int minPrice;
//   late final int maxPrice;
//   late final String image;
//
//   DiscountZone.fromJson(Map<String, dynamic> json){
//     name = json['name'];
//     minPrice = json['min_price'];
//     maxPrice = json['max_price'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['min_price'] = minPrice;
//     _data['max_price'] = maxPrice;
//     _data['image'] = image;
//     return _data;
//   }
// }
//
// class AppLinks {
//   AppLinks({
//     required this.andorid,
//     required this.ios,
//   });
//   late final String andorid;
//   late final String ios;
//
//   AppLinks.fromJson(Map<String, dynamic> json){
//     andorid = json['andorid'];
//     ios = json['ios'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['andorid'] = andorid;
//     _data['ios'] = ios;
//     return _data;
//   }
// }
//
// class DefaultLocation {
//   DefaultLocation({
//     required this.id,
//     required this.locationText,
//     required this.locationStr,
//     required this.locationLat,
//     required this.locationLong,
//     required this.status,
//     required this.insertDate,
//     required this.updateDate,
//   });
//   late final String id;
//   late final String locationText;
//   late final String locationStr;
//   late final String locationLat;
//   late final String locationLong;
//   late final String status;
//   late final String insertDate;
//   late final String updateDate;
//
//   DefaultLocation.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     locationText = json['location_text'];
//     locationStr = json['location_str'];
//     locationLat = json['location_lat'];
//     locationLong = json['location_long'];
//     status = json['status'];
//     insertDate = json['insert_date'];
//     updateDate = json['update_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['location_text'] = locationText;
//     _data['location_str'] = locationStr;
//     _data['location_lat'] = locationLat;
//     _data['location_long'] = locationLong;
//     _data['status'] = status;
//     _data['insert_date'] = insertDate;
//     _data['update_date'] = updateDate;
//     return _data;
//   }
// }
//
// class TopProducMen {
//   TopProducMen({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducMen.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducWomen {
//   TopProducWomen({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducWomen.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducFootwear {
//   TopProducFootwear({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducFootwear.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducMobile {
//   TopProducMobile({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducMobile.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducMobileAccessories {
//   TopProducMobileAccessories({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducMobileAccessories.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducHomeAppliance {
//   TopProducHomeAppliance({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducHomeAppliance.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducComputerAccessories {
//   TopProducComputerAccessories({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducComputerAccessories.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducFashionAccessories {
//   TopProducFashionAccessories({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducFashionAccessories.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducEyeWearandcare {
//   TopProducEyeWearandcare({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducEyeWearandcare.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducHomeDecor {
//   TopProducHomeDecor({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducHomeDecor.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducBagsAndLuggage {
//   TopProducBagsAndLuggage({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducBagsAndLuggage.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducBeauty {
//   TopProducBeauty({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducBeauty.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducFoodDrinks {
//   TopProducFoodDrinks({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducFoodDrinks.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducAutomotive {
//   TopProducAutomotive({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducAutomotive.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }
//
// class TopProducfinishingMaterial {
//   TopProducfinishingMaterial({
//     required this.productId,
//     required this.productTitle,
//     required this.productSlug,
//     required this.productCategory,
//     required this.productImage,
//   });
//   late final String productId;
//   late final String productTitle;
//   late final String productSlug;
//   late final String productCategory;
//   late final String productImage;
//
//   TopProducfinishingMaterial.fromJson(Map<String, dynamic> json){
//     productId = json['product_id'];
//     productTitle = json['product_title'];
//     productSlug = json['product_slug'];
//     productCategory = json['product_category'];
//     productImage = json['product_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['product_id'] = productId;
//     _data['product_title'] = productTitle;
//     _data['product_slug'] = productSlug;
//     _data['product_category'] = productCategory;
//     _data['product_image'] = productImage;
//     return _data;
//   }
// }