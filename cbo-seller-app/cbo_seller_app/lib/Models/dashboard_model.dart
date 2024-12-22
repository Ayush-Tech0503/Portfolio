class DashboardData {
  String? likedCount;
  String? wishlistCount;
  int? wnatBuyCount;
  int? wnatSellCount;
  dynamic? orderCount;
  String? productCount;
  String? approvedCount;
  String? reviewRatingCount;
  String? pendingCount;
  int? reelCount;

  DashboardData({
    this.likedCount,
    this.wishlistCount,
    this.wnatBuyCount,
    this.wnatSellCount,
    this.productCount,
    this.orderCount,
    this.approvedCount,
    this.reviewRatingCount,
    this.pendingCount,
    this.reelCount,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      likedCount: json['dashboard_data']['liked_count'],
      wishlistCount: json['dashboard_data']['wishlist_count'],
      wnatBuyCount: json['dashboard_data']['wnat_buy_count'],
      wnatSellCount: json['dashboard_data']['wnat_sell_count'],
      productCount: json['dashboard_data']['product_count'],
      orderCount: json['dashboard_data']['order_count'],
      approvedCount: json['dashboard_data']['approved_count'],
      reviewRatingCount: json['dashboard_data']['review_rating_count'],
      pendingCount: json['dashboard_data']['pending_count'],
      reelCount: json['dashboard_data']['reel_count'],
    );
  }

}

class CountSellerRating {
  int? count5;
  int? count4;
  int? count3;
  int? count2;
  int? count1;
  int? all;

  CountSellerRating({
    this.count5,
    this.count4,
    this.count3,
    this.count2,
    this.count1,
    this.all,
  });

  factory CountSellerRating.fromJson(Map<String, dynamic> json) {
    return CountSellerRating(
      count5: json['5'],
      count4: json['4'],
      count3: json['3'],
      count2: json['2'],
      count1: json['1'],
      all: json['all'],
    );
  }
}

class SellerData {
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

  SellerData({
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

  factory SellerData.fromJson(Map<String, dynamic> json) {
    return SellerData(
      sellerId: json['seller_id'],
      userId: json['user_id'],
      storeName: json['store_name'],
      legalBusinessName: json['legal_business_name'],
      storeSlug: json['store_slug'],
      designation: json['designation'],
      storeDescription: json['store_description'],
      storeAddress: json['store_address'],
      storeLocAddress: json['store_loc_address'],
      landmark: json['landmark'],
      storeLatitude: json['store_latitude'],
      storeLongitude: json['store_longitude'],
      countryId: json['country_id'],
      stateId: json['state_id'],
      cityId: json['city_id'],
      pincode: json['pincode'],
      contactNo: json['contact_no'],
      contactNoOpt: json['contact_no_opt'],
      referralCode: json['referral_code'],
      scRegistrationType: json['sc_registration_type'],
      otherScRegType: json['other_sc_reg_type'],
      scRegistrationFile: json['sc_registration_file'],
      gstNo: json['gst_no'],
      storeLogoName: json['store_logo_name'],
      brochureImage: json['brochure_image'],
      storeBannerName: json['store_banner_name'],
      facebookUrl: json['facebook_url'],
      instagramUrl: json['instagram_url'],
      twitterUrl: json['twitter_url'],
      metaTitle: json['meta_title'],
      metaKeyword: json['meta_keyword'],
      metaDescription: json['meta_description'],
      isActive: json['is_active'],
      isApproved: json['is_approved'],
      isBlocked: json['is_blocked'],
      createdDate: json['created_date'],
      createdBy: json['created_by'],
      modifiedDate: json['modified_date'],
      modifiedBy: json['modified_by'],
      dealsIn: json['deals_in'],
      buyOrRent: json['buy_or_rent'],
      rejectionDate: json['rejection_date'],
      rejectionRemarks: json['rejection_remarks'],
      deliveryMode: json['delivery_mode'],
      cityLandmarkId: json['city_landmark_id'],
      isActivePlan: json['is_active_plan'],
      paymentModesAccepted: json['payment_modes_accepted'],
      yearOfEstablishment: json['year_of_establishment'],
      sellerCategory: json['seller_category'],
      page: json['page'],
      email: json['email'],
      mobile: json['mobile'],
      stateName: json['state_name'],
      cityName: json['city_name'],
    );
  }
}

class MSubsData {
  String? sellerSubscriptionId;
  String? orderId;
  String? sellerId;
  String? subscriptionId;
  PlanDetails? planDetails;
  String? sbuscriptionStartDate;
  String? sbuscriptionEndDate;
  String? sbuscriptionDate;
  String? isActive;
  String? paymentStatus;
  String? createdDate;
  String? planType;
  String? isEmi;
  String? emiId;
  String? emiCycle;
  String?durationMonth;
  String? paymentId;
  String? isCouponApplied;
  String? couponCode;
  String? planAmt;
  String? orderAmt;
  String? taxableAmt;
  String? discountAmt;
  String? existingPlanDiscount;
  String? taxAmt;
  String? transactionAmt;
  String? transactionId;
  String? transactionDetails;
  String? couponDetails;
  String? transactionStatus;
  String? createdBy;
  String? invoiceNo;
  String? gstinNo;
  String? cgst;
  String? sgst;
  String? igst;

  MSubsData({
    this.sellerSubscriptionId,
    this.orderId,
    this.sellerId,
    this.subscriptionId,
    this.planDetails,
    this.sbuscriptionStartDate,
    this.sbuscriptionEndDate,
    this.sbuscriptionDate,
    this.isActive,
    this.paymentStatus,
    this.createdDate,
    this.planType,
    this.isEmi,
    this.emiId,
    this.emiCycle,
    this.durationMonth,
    this.paymentId,
    this.isCouponApplied,
    this.couponCode,
    this.planAmt,
    this.orderAmt,
    this.taxableAmt,
    this.discountAmt,
    this.existingPlanDiscount,
    this.taxAmt,
    this.transactionAmt,
    this.transactionId,
    this.transactionDetails,
    this.couponDetails,
    this.transactionStatus,
    this.createdBy,
    this.invoiceNo,
    this.gstinNo,
    this.cgst,
    this.sgst,
    this.igst,
  });

  factory MSubsData.fromJson(Map<String, dynamic> json) {
    return MSubsData(
      sellerSubscriptionId: json['seller_subscription_id'],
      orderId: json['order_id'],
      sellerId: json['seller_id'],
      subscriptionId: json['subscription_id'],
      planDetails: PlanDetails.fromJson(json['plan_details']),
      sbuscriptionStartDate: json['sbuscription_start_date'],
      sbuscriptionEndDate: json['sbuscription_end_date'],
      sbuscriptionDate: json['sbuscription_date'],
      isActive: json['is_active'],
      paymentStatus: json['payment_status'],
      createdDate: json['created_date'],
      planType: json['plan_type'],
      isEmi: json['is_emi'],
      emiId: json['emi_id'],
      emiCycle: json['emi_cycle'],
      durationMonth: json['duration_month'],
      paymentId: json['payment_id'],
      isCouponApplied: json['is_coupon_applied'],
      couponCode: json['coupon_code'],
      planAmt: json['plan_amt'],
      orderAmt: json['order_amt'],
      taxableAmt: json['taxable_amt'],
      discountAmt: json['discount_amt'],
      existingPlanDiscount: json['existing_plan_discount'],
      taxAmt: json['tax_amt'],
      transactionAmt: json['transaction_amt'],
      transactionId: json['transaction_id'],
      transactionDetails: json['transaction_details'],
      couponDetails: json['coupon_details'],
      transactionStatus: json['transaction_status'],
      createdBy: json['created_by'],
      invoiceNo: json['invoice_no'],
      gstinNo: json['gstin_no'],
      cgst: json['cgst'],
      sgst: json['sgst'],
      igst: json['igst'],
    );
  }
}

class PlanDetails {
  String? subscriptionId;
  String? subscriptionName;
  String? subscriptionDetails;
  String? subscriptionPrice;
  String? quarterlyPrice;
  String? halfYearlyPrice;
  String? yearlyPrice;
  String? noOfProductAllowed;
  String? wantToBuyLimit;
  String? subscriptionValidity;
  String? socialShareCitybazar;
  String? adBannerOfferAdda;
  String? visitorAnalytics;
  String? discountSection;
  String? shopInFocus;
  String? topProduct;
  String? executeVisitUploads;
  String? isActive;
  String? isDeleted;
  String? createdBy;
  String? createdDate;
  String? modifiedBy;
  String? modifiedDate;
  String? socialBoosting;

  PlanDetails({
    this.subscriptionId,
    this.subscriptionName,
    this.subscriptionDetails,
    this.subscriptionPrice,
    this.quarterlyPrice,
    this.halfYearlyPrice,
    this.yearlyPrice,
    this.noOfProductAllowed,
    this.wantToBuyLimit,
    this.subscriptionValidity,
    this.socialShareCitybazar,
    this.adBannerOfferAdda,
    this.visitorAnalytics,
    this.discountSection,
    this.shopInFocus,
    this.topProduct,
    this.executeVisitUploads,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.socialBoosting,
  });

  factory PlanDetails.fromJson(Map<String, dynamic> json) {
    return PlanDetails(
      subscriptionId: json['subscription_id'],
      subscriptionName: json['subscription_name'],
      subscriptionDetails: json['subscription_details'],
      subscriptionPrice: json['subscription_price'],
      quarterlyPrice: json['quarterly_price'],
      halfYearlyPrice: json['half_yearly_price'],
      yearlyPrice: json['yearly_price'],
      noOfProductAllowed: json['no_of_product_allowed'],
      wantToBuyLimit: json['want_to_buy_limit'],
      subscriptionValidity: json['subscription_validity'],
      socialShareCitybazar: json['social_share_citybazar'],
      adBannerOfferAdda: json['ad_banner_offer_adda'],
      visitorAnalytics: json['visitor_analytics'],
      discountSection: json['discount_section'],
      shopInFocus: json['shop_in_focus'],
      topProduct: json['top_product'],
      executeVisitUploads: json['execute_visit_uploads'],
      isActive: json['is_active'],
      isDeleted: json['is_deleted'],
      createdBy: json['created_by'],
      createdDate: json['created_date'],
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'],
      socialBoosting: json['social_boosting'],
    );
  }
}

class CountFollowerSeller {
  int? countFollowerSeller;

  CountFollowerSeller({this.countFollowerSeller});

  factory CountFollowerSeller.fromJson(Map<String, dynamic> json) {
    return CountFollowerSeller(countFollowerSeller: json['countFollowerSeller'],);
  }
}

class CbDetails {
  String? id;
  String? sellerId;
  String? orderId;
  String? sellerName;
  String? mobileNumber;
  String? subscription;
  String? cbPercenta;
  String? partA;
  String? partB;
  String? partBMini;
  String? partAMaxi;
  String? cbLimitSelle;
  String? maximumCash;
  String? minimumUser;
  String? maximumUser;
  String? status;
  String? isActive;
  String? sbuscriptionStatus;
  String? sbuscriptionEndDate;
  String? insertDate;
  String? updateDate;

  CbDetails({
    this.id,
    this.sellerId,
    this.orderId,
    this.sellerName,
    this.mobileNumber,
    this.subscription,
    this.cbPercenta,
    this.partA,
    this.partB,
    this.partBMini,
    this.partAMaxi,
    this.cbLimitSelle,
    this.maximumCash,
    this.minimumUser,
    this.maximumUser,
    this.status,
    this.isActive,
    this.sbuscriptionStatus,
    this.sbuscriptionEndDate,
    this.insertDate,
    this.updateDate,
  });

  factory CbDetails.fromJson(Map<String, dynamic> json) {
    return CbDetails(
      id: json['id'],
      sellerId: json['seller_id'],
      orderId: json['order_id'],
      sellerName: json['seller_name'],
      mobileNumber: json['mobile_number'],
      subscription: json['subscription'],
      cbPercenta: json['cb_percenta'],
      partA: json['part_a'],
      partB: json['part_b'],
      partBMini: json['part_b_mini'],
      partAMaxi: json['part_a_maxi'],
      cbLimitSelle: json['cb_limit_selle'],
      maximumCash: json['maximum_cash'],
      minimumUser: json['minimum_user'],
      maximumUser: json['maximum_user'],
      status: json['status'],
      isActive: json['is_active'],
      sbuscriptionStatus: json['sbuscription_status'],
      sbuscriptionEndDate: json['sbuscription_end_date'],
      insertDate: json['insert_date'],
      updateDate: json['update_date'],
    );
  }
}

class JsonData {
  DashboardData? dashboardData;
  CountSellerRating? countSellerRating;
  SellerData? sellerData;
  List<MSubsData>? mSubsData;
  CountFollowerSeller? countFollowerSeller;
  List<CbDetails>? cbDetails;
  double? cashBackWon;

  JsonData({
    this.dashboardData,
    this.countSellerRating,
    this.sellerData,
    this.mSubsData,
    this.countFollowerSeller,
    this.cbDetails,
    this.cashBackWon,
  });

  factory JsonData.fromJson(Map<String, dynamic> json) {
    return JsonData(
      dashboardData: DashboardData.fromJson(json['dashboard_data']),
      countSellerRating: CountSellerRating.fromJson(json['countSellerRating']),
      sellerData: SellerData.fromJson(json['seller_data']),
      mSubsData: List<MSubsData>.from(json['msubs_data'].map((x) => MSubsData.fromJson(x))),
      countFollowerSeller: CountFollowerSeller.fromJson(json['countFollowerSeller']),
      cbDetails: List<CbDetails>.from(json['cb_details'].map((x) => CbDetails.fromJson(x))),
      cashBackWon: json['cash_back_won'].toDouble(),
    );
  }
}



