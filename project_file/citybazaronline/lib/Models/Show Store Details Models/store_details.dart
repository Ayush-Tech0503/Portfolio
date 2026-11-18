class ShowStoreDetails {
  String? status;
  Data? data;
  String? shareLink;

  ShowStoreDetails({this.status, this.data, this.shareLink});

  ShowStoreDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    shareLink = json['share_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['share_link'] = shareLink;
    return data;
  }
}

class Data {
  SellerDetails? sellerDetails;
  List<SellerOpenHrs>? sellerOpenHrs;
  List<PhotoGallery>? photoGallery;
  List<SellerCategories>? sellerCategories;
  AvgRating? avgRating;
  StarRatingCount? starRatingCount;
  String? followVal;
  List<Reveiws>? reveiws;

  Data(
      {this.sellerDetails,
        this.sellerOpenHrs,
        this.photoGallery,
        this.sellerCategories,
        this.avgRating,
        this.starRatingCount,
        this.followVal,
        this.reveiws});

  Data.fromJson(Map<String, dynamic> json) {
    sellerDetails = json['seller_details'] != null
        ? SellerDetails.fromJson(json['seller_details'])
        : null;
    if (json['seller_open_hrs'] != null) {
      sellerOpenHrs = <SellerOpenHrs>[];
      json['seller_open_hrs'].forEach((v) {
        sellerOpenHrs!.add(SellerOpenHrs.fromJson(v));
      });
    }
    if (json['photoGallery'] != null) {
      photoGallery = <PhotoGallery>[];
      json['photoGallery'].forEach((v) {
        photoGallery!.add(PhotoGallery.fromJson(v));
      });
    }
    if (json['seller_categories'] != null) {
      sellerCategories = <SellerCategories>[];
      json['seller_categories'].forEach((v) {
        sellerCategories!.add(SellerCategories.fromJson(v));
      });
    }
    avgRating = json['avg_rating'] != null
        ? AvgRating.fromJson(json['avg_rating'])
        : null;
    starRatingCount = json['StarRatingCount'] != null
        ? StarRatingCount.fromJson(json['StarRatingCount'])
        : null;
    followVal = json['follow_val'];
    if (json['reveiws'] != null) {
      reveiws = <Reveiws>[];
      json['reveiws'].forEach((v) {
        reveiws!.add(Reveiws.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sellerDetails != null) {
      data['seller_details'] = sellerDetails!.toJson();
    }
    if (sellerOpenHrs != null) {
      data['seller_open_hrs'] =
          sellerOpenHrs!.map((v) => v.toJson()).toList();
    }
    if (photoGallery != null) {
      data['photoGallery'] = photoGallery!.map((v) => v.toJson()).toList();
    }
    if (sellerCategories != null) {
      data['seller_categories'] =
          sellerCategories!.map((v) => v.toJson()).toList();
    }
    if (avgRating != null) {
      data['avg_rating'] = avgRating!.toJson();
    }
    if (starRatingCount != null) {
      data['StarRatingCount'] = starRatingCount!.toJson();
    }
    data['follow_val'] = followVal;
    if (reveiws != null) {
      data['reveiws'] = reveiws!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerDetails {
  String? sellerId;
  String? userId;
  String? storeName;
  String? legalBusinessName;
  String? storeSlug;
  String? designation;
  String? storeDescription;
  String? storeAddress;
  String? storeLocAddress;
  String? landmark;
  String? storeLatitude;
  String? storeLongitude;
  String? countryId;
  String? stateId;
  String? cityId;
  String? pincode;
  String? contactNo;
  String? whatsapptext;
  String? contactNoOpt;
  String? referralCode;
  String? scRegistrationType;
  String? otherScRegType;
  String? scRegistrationFile;
  String? gstNo;
  String? storeLogoName;
  String? brochureImage;
  String? storeBannerName;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? metaTitle;
  String? metaKeyword;
  String? metaDescription;
  String? isActive;
  String? isApproved;
  String? isBlocked;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  List<String>? dealsIn;
  String? buyOrRent;
  String? rejectionDate;
  String? rejectionRemarks;
  String? deliveryMode;
  String? cityLandmarkId;
  String? isActivePlan;
  String? paymentModesAccepted;
  String? yearOfEstablishment;
  String? sellerCategory;
  String? page;
  String? storeImageUrl;
  String? storeBannerUrl;
  String? email;
  String? avgRating;
  String? todayStatus;
  bool? cashbackTag;
  String? cashbackText;

  SellerDetails(
      {this.sellerId,
        this.userId,
        this.storeName,
        this.legalBusinessName,
        this.storeSlug,
        this.designation,
        this.storeDescription,
        this.storeAddress,
        this.storeLocAddress,
        this.landmark,
        this.storeLatitude,
        this.storeLongitude,
        this.countryId,
        this.stateId,
        this.cityId,
        this.pincode,
        this.contactNo,
        this.whatsapptext,
        this.contactNoOpt,
        this.referralCode,
        this.scRegistrationType,
        this.otherScRegType,
        this.scRegistrationFile,
        this.gstNo,
        this.storeLogoName,
        this.brochureImage,
        this.storeBannerName,
        this.facebookUrl,
        this.instagramUrl,
        this.twitterUrl,
        this.metaTitle,
        this.metaKeyword,
        this.metaDescription,
        this.isActive,
        this.isApproved,
        this.isBlocked,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.dealsIn,
        this.buyOrRent,
        this.rejectionDate,
        this.rejectionRemarks,
        this.deliveryMode,
        this.cityLandmarkId,
        this.isActivePlan,
        this.paymentModesAccepted,
        this.yearOfEstablishment,
        this.sellerCategory,
        this.page,
        this.storeImageUrl,
        this.storeBannerUrl,
        this.email,
        this.avgRating,
        this.todayStatus,
        this.cashbackTag,
        this.cashbackText});

  SellerDetails.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    userId = json['user_id'];
    storeName = json['store_name'];
    legalBusinessName = json['legal_business_name'];
    storeSlug = json['store_slug'];
    designation = json['designation'];
    storeDescription = json['store_description'];
    storeAddress = json['store_address'];
    storeLocAddress = json['store_loc_address'];
    landmark = json['landmark'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    contactNo = json['contact_no'];
    whatsapptext = json['whatsapptext'];
    contactNoOpt = json['contact_no_opt'];
    referralCode = json['referral_code'];
    scRegistrationType = json['sc_registration_type'];
    otherScRegType = json['other_sc_reg_type'];
    scRegistrationFile = json['sc_registration_file'];
    gstNo = json['gst_no'];
    storeLogoName = json['store_logo_name'];
    brochureImage = json['brochure_image'];
    storeBannerName = json['store_banner_name'];
    facebookUrl = json['facebook_url'];
    instagramUrl = json['instagram_url'];
    twitterUrl = json['twitter_url'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    isActive = json['is_active'];
    isApproved = json['is_approved'];
    isBlocked = json['is_blocked'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    modifiedDate = json['modified_date'];
    modifiedBy = json['modified_by'];
    dealsIn = json['deals_in'].cast<String>();
    buyOrRent = json['buy_or_rent'];
    rejectionDate = json['rejection_date'];
    rejectionRemarks = json['rejection_remarks'];
    deliveryMode = json['delivery_mode'];
    cityLandmarkId = json['city_landmark_id'];
    isActivePlan = json['is_active_plan'];
    paymentModesAccepted = json['payment_modes_accepted'];
    yearOfEstablishment = json['year_of_establishment'];
    sellerCategory = json['seller_category'];
    page = json['page'];
    storeImageUrl = json['store_image_url'];
    storeBannerUrl = json['store_banner_url'];
    email = json['email'];
    avgRating = json['avg_rating'];
    todayStatus = json['today_status'];
    cashbackTag = json['cashback_tag'];
    cashbackText = json['cashback_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['user_id'] = userId;
    data['store_name'] = storeName;
    data['legal_business_name'] = legalBusinessName;
    data['store_slug'] = storeSlug;
    data['designation'] = designation;
    data['store_description'] = storeDescription;
    data['store_address'] = storeAddress;
    data['store_loc_address'] = storeLocAddress;
    data['landmark'] = landmark;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['contact_no'] = contactNo;
    data['whatsapptext'] = whatsapptext;
    data['contact_no_opt'] = contactNoOpt;
    data['referral_code'] = referralCode;
    data['sc_registration_type'] = scRegistrationType;
    data['other_sc_reg_type'] = otherScRegType;
    data['sc_registration_file'] = scRegistrationFile;
    data['gst_no'] = gstNo;
    data['store_logo_name'] = storeLogoName;
    data['brochure_image'] = brochureImage;
    data['store_banner_name'] = storeBannerName;
    data['facebook_url'] = facebookUrl;
    data['instagram_url'] = instagramUrl;
    data['twitter_url'] = twitterUrl;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['meta_description'] = metaDescription;
    data['is_active'] = isActive;
    data['is_approved'] = isApproved;
    data['is_blocked'] = isBlocked;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['modified_date'] = modifiedDate;
    data['modified_by'] = modifiedBy;
    data['deals_in'] = dealsIn;
    data['buy_or_rent'] = buyOrRent;
    data['rejection_date'] = rejectionDate;
    data['rejection_remarks'] = rejectionRemarks;
    data['delivery_mode'] = deliveryMode;
    data['city_landmark_id'] = cityLandmarkId;
    data['is_active_plan'] = isActivePlan;
    data['payment_modes_accepted'] = paymentModesAccepted;
    data['year_of_establishment'] = yearOfEstablishment;
    data['seller_category'] = sellerCategory;
    data['page'] = page;
    data['store_image_url'] = storeImageUrl;
    data['store_banner_url'] = storeBannerUrl;
    data['email'] = email;
    data['avg_rating'] = avgRating;
    data['today_status'] = todayStatus;
    data['cashback_tag'] = cashbackTag;
    data['cashback_text'] = cashbackText;
    return data;
  }
}

class SellerOpenHrs {
  String? id;
  String? sellerId;
  String? day;
  String? onOff;
  String? opensAt;
  String? closesAt;
  String? createdDate;

  SellerOpenHrs(
      {this.id,
        this.sellerId,
        this.day,
        this.onOff,
        this.opensAt,
        this.closesAt,
        this.createdDate});

  SellerOpenHrs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    day = json['day'];
    onOff = json['on_off'];
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['day'] = day;
    data['on_off'] = onOff;
    data['opens_at'] = opensAt;
    data['closes_at'] = closesAt;
    data['created_date'] = createdDate;
    return data;
  }
}

class PhotoGallery {
  int? id;
  String? url;

  PhotoGallery({this.id, this.url});

  PhotoGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class SellerCategories {
  String? categoryId;
  String? categoryName;

  SellerCategories({this.categoryId, this.categoryName});

  SellerCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

class AvgRating {
  String? avgRating;

  AvgRating({this.avgRating});

  AvgRating.fromJson(Map<String, dynamic> json) {
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_rating'] = avgRating;
    return data;
  }
}

class StarRatingCount {
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;
  int? all;

  StarRatingCount({this.i1, this.i2, this.i3, this.i4, this.i5, this.all});

  StarRatingCount.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    data['all'] = all;
    return data;
  }
}

class Reveiws {
  String? user;
  String? userId;
  String? reveiw;
  String? rating;

  Reveiws({this.user, this.userId, this.reveiw, this.rating});

  Reveiws.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userId = json['user_id'];
    reveiw = json['reveiw'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['user_id'] = userId;
    data['reveiw'] = reveiw;
    data['rating'] = rating;
    return data;
  }
}
