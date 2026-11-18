class PreRegistration {
  PreRegistration({
    this.status,
    this.data,
  });
  String? status;
  Data? data;

  PreRegistration.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Data({
    this.states,
    this.userInfo,
    this.seller,
    this.childCat,
    this.sellerOpenHrs,
  });
  List<dynamic>? states;
  UserInfo? userInfo;
  Seller? seller;
  List<ChildCat>? childCat;
  List<dynamic>? sellerOpenHrs;

  Data.fromJson(Map<String, dynamic> json) {
    states = json['states'] != null ? List.castFrom<dynamic, dynamic>(json['states']) : null;
    userInfo = json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
   seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    childCat = json['child_cat'] != null
        ? List<ChildCat>.from((json['child_cat'] as List<dynamic>? ?? []).map((e) => ChildCat.fromJson(e)))
        : null;
    sellerOpenHrs = json['seller_open_hrs'] != null
        ? List.castFrom<dynamic, dynamic>(json['seller_open_hrs'])
        : null;
    // sellerOpenHrs = json['seller_open_hrs'] != null
    //     ? List<SellerOpenHrs>.from((json['seller_open_hrs'] as List<dynamic>).map((e) => SellerOpenHrs.fromJson(e)))
    //     : [];
    // if (json['seller_open_hrs'] != null) {
    //   if (json['seller_open_hrs'] is List) {
    //     sellerOpenHrs =
    //         (json['seller_open_hrs'] as List).map((e) => SellerOpenHrs.fromJson(e)).toList();
    //   } else {
    //     sellerOpenHrs = json['seller_open_hrs'] != null
    //         ? List.castFrom<dynamic, dynamic>(json['seller_open_hrs'])
    //         : null;
    //   }
    // }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (states != null) {
      data['states'] = states;
    }
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    if (seller != null && seller is Seller) {
      data['seller'] = seller!.toJson();
    }
    if (childCat != null) {
      data['child_cat'] = childCat!.map((e) => e.toJson()).toList();
    }
    if (sellerOpenHrs != null) {
      data['seller_open_hrs'] = sellerOpenHrs;
    }
    return data;
  }
}

class UserInfo {
  UserInfo({
    this.userId,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.otp,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.upi,
    this.isActive,
    this.isBlocked,
    this.isDisabled,
    this.registrationMedia,
    this.authProvider,
    this.authId,
    this.authByFacebook,
    this.facebookAuthId,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.refferalId,
    this.referenceBy,
    this.type,
    this.feedbackStatus,
  });
  String? userId;
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? otp;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? upi;
  String? isActive;
  String? isBlocked;
  String? isDisabled;
  String? registrationMedia;
  String? authProvider;
  String? authId;
  String? authByFacebook;
  String? facebookAuthId;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? refferalId;
  String? referenceBy;
  String? type;
  String? feedbackStatus;

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    otp = json['otp'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    upi = json['upi'];
    isActive = json['is_active'];
    isBlocked = json['is_blocked'];
    isDisabled = json['is_disabled'];
    registrationMedia = json['registration_media'];
    authProvider = json['auth_provider'];
    authId = json['auth_id'];
    authByFacebook = json['auth_by_facebook'];
    facebookAuthId = json['facebook_auth_id'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    modifiedDate = json['modified_date'];
    modifiedBy = json['modified_by'];
    refferalId = json['refferal_id'];
    referenceBy = json['reference_by'];
    type = json['type'];
    feedbackStatus = json['feedback_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['password'] = password;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['otp'] = otp;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['address'] = address;
    data['upi'] = upi;
    data['is_active'] = isActive;
    data['is_blocked'] = isBlocked;
    data['is_disabled'] = isDisabled;
    data['registration_media'] = registrationMedia;
    data['auth_provider'] = authProvider;
    data['auth_id'] = authId;
    data['auth_by_facebook'] = authByFacebook;
    data['facebook_auth_id'] = facebookAuthId;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['modified_date'] = modifiedDate;
    data['modified_by'] = modifiedBy;
    data['refferal_id'] = refferalId;
    data['reference_by'] = referenceBy;
    data['type'] = type;
    data['feedback_status'] = feedbackStatus;
    return data;
  }
}

class Seller {
  Seller({
    this.sellerId,
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
    this.email,
    this.mobile,
    this.stateName,
    this.cityName,
  });
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
  String? dealsIn;
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
  String? email;
  String? mobile;
  String? stateName;
  String? cityName;

  Seller.fromJson(Map<String, dynamic> json) {
    // print("jsom type ${json.runtimeType}");
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
    dealsIn = json['deals_in'];
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
    email = json['email'];
    mobile = json['mobile'];
    stateName = json['state_name'];
    cityName = json['city_name'];


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
    data['email'] = email;
    data['mobile'] = mobile;
    data['state_name'] = stateName;
    data['city_name'] = cityName;
    return data;
  }
}

class ChildCat {
  ChildCat({
   this.categoryId,
    this.cat,
    this.pcat1,
    this.pcat2,
    this.pcat3,
    this.isSelected,
  });
   String? categoryId;
  String? cat;
   String? pcat1;
   String? pcat2;
   String? pcat3;
  bool? isSelected;

  ChildCat.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id'];
    cat = json['cat'];
    pcat1 = json['pcat1'];
    pcat2 = json['pcat2'];
    pcat3 = json['pcat3'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['cat'] = cat;
    data['pcat1'] = pcat1;
    data['pcat2'] = pcat2;
    data['pcat3'] = pcat3;
    return data;
  }
}

class SellerOpenHrs {
  SellerOpenHrs({
     this.id,
     this.sellerId,
     this.day,
     this.onOff,
     this.opensAt,
     this.closesAt,
     this.createdDate,
  });
   String? id;
   String? sellerId;
    String? day;
    String? onOff;
    String? opensAt;
    String? closesAt;
    String? createdDate;

  SellerOpenHrs.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sellerId = json['seller_id'];
    day = json['day'];
    onOff = json['on_off'];
    opensAt = json['opens_at'];
    closesAt = json['closes_at'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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

//-------------------------------------------------------------