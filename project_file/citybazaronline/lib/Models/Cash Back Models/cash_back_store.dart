class CashBacks {
  String? status;
  int? walletAmount;
  List<Banners>? banner;
  List<TermsAndCondition>? termsAndCondition;
  List<Store>? store;

  CashBacks(
      {this.status,
        this.walletAmount,
        this.banner,
        this.termsAndCondition,
        this.store});

  CashBacks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    walletAmount = json['wallet_amount'];
    if (json['banner'] != null) {
      banner = <Banners>[];
      json['banner'].forEach((v) {
        banner!.add(Banners.fromJson(v));
      });
    }
    if (json['terms_and_condition'] != null) {
      termsAndCondition = <TermsAndCondition>[];
      json['terms_and_condition'].forEach((v) {
        termsAndCondition!.add(TermsAndCondition.fromJson(v));
      });
    }
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store!.add(Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['wallet_amount'] = walletAmount;
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    if (termsAndCondition != null) {
      data['terms_and_condition'] =
          termsAndCondition!.map((v) => v.toJson()).toList();
    }
    if (store != null) {
      data['store'] = store!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? addImage;
  String? def;

  Banners({this.addImage, this.def});

  Banners.fromJson(Map<String, dynamic> json) {
    addImage = json['add_image'];
    def = json['def'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add_image'] = addImage;
    data['def'] = def;
    return data;
  }
}

class TermsAndCondition {
  String? id;
  String? title;
  String? descripation;
  String? page;
  String? status;
  String? insertDate;
  String? updateDate;

  TermsAndCondition(
      {this.id,
        this.title,
        this.descripation,
        this.page,
        this.status,
        this.insertDate,
        this.updateDate});

  TermsAndCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    descripation = json['descripation'];
    page = json['page'];
    status = json['status'];
    insertDate = json['insert_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['descripation'] = descripation;
    data['page'] = page;
    data['status'] = status;
    data['insert_date'] = insertDate;
    data['update_date'] = updateDate;
    return data;
  }
}

class Store {
  String? sellerId;
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

  Store(
      {this.sellerId,
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
        this.cashbackText});

  Store.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
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
