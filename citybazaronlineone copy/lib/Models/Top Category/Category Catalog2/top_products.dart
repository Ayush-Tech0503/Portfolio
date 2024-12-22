class CategoryCat2TopStoresProducts  {
  CategoryCat2TopStoresProducts ({
      this.status,
      this.topStoreProducts,
      this.yourCityFocusStore,
  });
    String? status;
    List<CategoryCat2StoreProducts>? topStoreProducts;
    List<CategoryCat2Stores>? yourCityFocusStore;

  CategoryCat2TopStoresProducts .fromJson(Map<String, dynamic> json){
    status = json['status'];
  topStoreProducts = List.from(json['top_store_products']).map((e)=>CategoryCat2StoreProducts.fromJson(e)).toList();
    yourCityFocusStore = List.from(json['your_city_focus_store']).map((e)=>CategoryCat2Stores.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['top_store_products'] = topStoreProducts!.map((e)=>e.toJson()).toList();
    data['your_city_focus_store'] = yourCityFocusStore!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class CategoryCat2StoreProducts {
  CategoryCat2StoreProducts({
       this.createdBy,
      this.productId,
      this.productTitle,
      this.productSlug,
      this.productCategory,
      this.price,
    this.offerPrice,
      this.productImage,
      this.storeName,
      this.cashbackTag,
      this.cashbackText,
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
    String? productImage;
    String? storeName;
    bool? cashbackTag;
    String? cashbackText;
    String? contactNo;
    String? shareLink;
    String? whatsapptext;
    String? wantToBuy;

  CategoryCat2StoreProducts.fromJson(Map<String, dynamic> json){
    createdBy = json['created_by'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    productCategory = json['product_category'];
    price = json['price'];
    offerPrice = json['offer_price'];
    productImage = json['product_image'];
    storeName = json['store_name'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
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
    data['product_image'] = productImage;
    data['store_name'] = storeName;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    data['contact_no'] = contactNo;
    data['share_link'] = shareLink;
    data['whatsapptext'] = whatsapptext;
    data['want_to_buy'] = wantToBuy;
    return data;
  }
}
class CategoryCat2Stores {
  CategoryCat2Stores({
      this.sellerId,
      this.dealsIn,
      this.storeLogoName,
      this.name,
      this.storeAddress,
      this.storeSlug,
      this.contactNo,
      this.storeLatitude,
      this.storeLongitude,
      this.shopImage,
      this.rating,
      this.cashbackTag,
      this.cashbackText,
  });
    String? sellerId;
    String? dealsIn;
    String? storeLogoName;
    String? name;
    String? storeAddress;
    String? storeSlug;
    String? contactNo;
    String? storeLatitude;
    String? storeLongitude;
    String? shopImage;
    String? rating;
    bool? cashbackTag;
    String? cashbackText;

  CategoryCat2Stores.fromJson(Map<String, dynamic> json){
    sellerId = json['seller_id'];
    dealsIn = json['deals_in'];
    storeLogoName = json['store_logo_name'];
    name = json['name'];
    storeAddress = json['store_address'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    shopImage = json['shop_image'];
    rating = json['rating'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['deals_in'] = dealsIn;
    data['store_logo_name'] = storeLogoName;
    data['name'] = name;
    data['store_address'] = storeAddress;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['shop_image'] = shopImage;
    data['rating'] = rating;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}