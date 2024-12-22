// class DashboardSeller {
//   String? status;
//   DashboardData? dashboardData;
//   CountSellerRating? countSellerRating;
//   SellerData? sellerData;
//   List<MsubsData>? msubsData;
//   int? countFollowerSeller;
//   List<CbDetails>? cbDetails;
//   double? cashBackWon;
//
//   DashboardSeller(
//       {this.status,
//         this.dashboardData,
//         this.countSellerRating,
//         this.sellerData,
//         this.msubsData,
//         this.countFollowerSeller,
//         this.cbDetails,
//         this.cashBackWon});
//
//   DashboardSeller.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     dashboardData = json['dashboard_data'] != null
//         ? new DashboardData.fromJson(json['dashboard_data'])
//         : null;
//     countSellerRating = json['countSellerRating'] != null
//         ? new CountSellerRating.fromJson(json['countSellerRating'])
//         : null;
//     sellerData = json['seller_data'] != null
//         ? new SellerData.fromJson(json['seller_data'])
//         : null;
//     if (json['msubs_data'] != null) {
//       msubsData = <MsubsData>[];
//       json['msubs_data'].forEach((v) {
//         msubsData!.add(new MsubsData.fromJson(v));
//       });
//     }
//     countFollowerSeller = json['countFollowerSeller'];
//     if (json['cb_details'] != null) {
//       cbDetails = <CbDetails>[];
//       json['cb_details'].forEach((v) {
//         cbDetails!.add(new CbDetails.fromJson(v));
//       });
//     }
//     cashBackWon = json['cash_back_won'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (dashboardData != null) {
//       data['dashboard_data'] = dashboardData!.toJson();
//     }
//     if (countSellerRating != null) {
//       data['countSellerRating'] = countSellerRating!.toJson();
//     }
//     if (sellerData != null) {
//       data['seller_data'] = sellerData!.toJson();
//     }
//     if (msubsData != null) {
//       data['msubs_data'] = msubsData!.map((v) => v.toJson()).toList();
//     }
//     data['countFollowerSeller'] = countFollowerSeller;
//     if (cbDetails != null) {
//       data['cb_details'] = cbDetails!.map((v) => v.toJson()).toList();
//     }
//     data['cash_back_won'] = cashBackWon;
//     return data;
//   }
// }
//
// class CountFollowerSeller {
//   int? countFollowerSeller;
//
//   CountFollowerSeller(
//       {this.countFollowerSeller}
//       );
//
//   CountFollowerSeller.fromJson(Map<String, dynamic> json) {
//     countFollowerSeller = json['countFollowerSeller'];
//   }
//
// }
//
// class DashboardData {
//   String? likedCount;
//   String? wishlistCount;
//   int? wnatBuyCount;
//   int? wnatSellCount;
//   String? productCount;
//   String? approvedCount;
//   String? pendingCount;
//
//   DashboardData(
//       {this.likedCount,
//         this.wishlistCount,
//         this.wnatBuyCount,
//         this.wnatSellCount,
//         this.productCount,
//         this.approvedCount,
//         this.pendingCount});
//
//   DashboardData.fromJson(Map<String, dynamic> json) {
//     likedCount = json['liked_count'];
//     wishlistCount = json['wishlist_count'];
//     wnatBuyCount = json['wnat_buy_count'];
//     wnatSellCount = json['wnat_sell_count'];
//     productCount = json['product_count'];
//     approvedCount = json['approved_count'];
//     pendingCount = json['pending_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['liked_count'] = likedCount;
//     data['wishlist_count'] = wishlistCount;
//     data['wnat_buy_count'] = wnatBuyCount;
//     data['wnat_sell_count'] = wnatSellCount;
//     data['product_count'] = productCount;
//     data['approved_count'] = approvedCount;
//     data['pending_count'] = pendingCount;
//     return data;
//   }
// }
//
// class CountSellerRating {
//   int? i1;
//   int? i2;
//   int? i3;
//   int? i4;
//   int? i5;
//   int? all;
//
//   CountSellerRating({this.i1, this.i2, this.i3, this.i4, this.i5, this.all});
//
//   CountSellerRating.fromJson(Map<String, dynamic> json) {
//     i1 = json['1'];
//     i2 = json['2'];
//     i3 = json['3'];
//     i4 = json['4'];
//     i5 = json['5'];
//     all = json['all'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['1'] = i1;
//     data['2'] = i2;
//     data['3'] = i3;
//     data['4'] = i4;
//     data['5'] = i5;
//     data['all'] = all;
//     return data;
//   }
// }
//
// class SellerData {
//   String? sellerId;
//   String? userId;
//   String? storeName;
//   String? legalBusinessName;
//   String? storeSlug;
//   String? designation;
//   String? storeDescription;
//   String? storeAddress;
//   String? storeLocAddress;
//   String? landmark;
//   String? storeLatitude;
//   String? storeLongitude;
//   String? countryId;
//   String? stateId;
//   String? cityId;
//   String? pincode;
//   String? contactNo;
//   String? contactNoOpt;
//   String? referralCode;
//   String? scRegistrationType;
//   String? otherScRegType;
//   String? scRegistrationFile;
//   String? gstNo;
//   String? storeLogoName;
//   String? brochureImage;
//   String? storeBannerName;
//   Null? facebookUrl;
//   Null? instagramUrl;
//   Null? twitterUrl;
//   String? metaTitle;
//   String? metaKeyword;
//   String? metaDescription;
//   String? isActive;
//   String? isApproved;
//   String? isBlocked;
//   String? createdDate;
//   String? createdBy;
//   String? modifiedDate;
//   String? modifiedBy;
//   String? dealsIn;
//   String? buyOrRent;
//   Null? rejectionDate;
//   Null? rejectionRemarks;
//   String? deliveryMode;
//   String? cityLandmarkId;
//   String? isActivePlan;
//   String? paymentModesAccepted;
//   String? yearOfEstablishment;
//   String? sellerCategory;
//   String? page;
//   String? email;
//   String? mobile;
//   Null? stateName;
//   Null? cityName;
//
//   SellerData(
//       {this.sellerId,
//         this.userId,
//         this.storeName,
//         this.legalBusinessName,
//         this.storeSlug,
//         this.designation,
//         this.storeDescription,
//         this.storeAddress,
//         this.storeLocAddress,
//         this.landmark,
//         this.storeLatitude,
//         this.storeLongitude,
//         this.countryId,
//         this.stateId,
//         this.cityId,
//         this.pincode,
//         this.contactNo,
//         this.contactNoOpt,
//         this.referralCode,
//         this.scRegistrationType,
//         this.otherScRegType,
//         this.scRegistrationFile,
//         this.gstNo,
//         this.storeLogoName,
//         this.brochureImage,
//         this.storeBannerName,
//         this.facebookUrl,
//         this.instagramUrl,
//         this.twitterUrl,
//         this.metaTitle,
//         this.metaKeyword,
//         this.metaDescription,
//         this.isActive,
//         this.isApproved,
//         this.isBlocked,
//         this.createdDate,
//         this.createdBy,
//         this.modifiedDate,
//         this.modifiedBy,
//         this.dealsIn,
//         this.buyOrRent,
//         this.rejectionDate,
//         this.rejectionRemarks,
//         this.deliveryMode,
//         this.cityLandmarkId,
//         this.isActivePlan,
//         this.paymentModesAccepted,
//         this.yearOfEstablishment,
//         this.sellerCategory,
//         this.page,
//         this.email,
//         this.mobile,
//         this.stateName,
//         this.cityName});
//
//   SellerData.fromJson(Map<String, dynamic> json) {
//     sellerId = json['seller_id'];
//     userId = json['user_id'];
//     storeName = json['store_name'];
//     legalBusinessName = json['legal_business_name'];
//     storeSlug = json['store_slug'];
//     designation = json['designation'];
//     storeDescription = json['store_description'];
//     storeAddress = json['store_address'];
//     storeLocAddress = json['store_loc_address'];
//     landmark = json['landmark'];
//     storeLatitude = json['store_latitude'];
//     storeLongitude = json['store_longitude'];
//     countryId = json['country_id'];
//     stateId = json['state_id'];
//     cityId = json['city_id'];
//     pincode = json['pincode'];
//     contactNo = json['contact_no'];
//     contactNoOpt = json['contact_no_opt'];
//     referralCode = json['referral_code'];
//     scRegistrationType = json['sc_registration_type'];
//     otherScRegType = json['other_sc_reg_type'];
//     scRegistrationFile = json['sc_registration_file'];
//     gstNo = json['gst_no'];
//     storeLogoName = json['store_logo_name'];
//     brochureImage = json['brochure_image'];
//     storeBannerName = json['store_banner_name'];
//     facebookUrl = json['facebook_url'];
//     instagramUrl = json['instagram_url'];
//     twitterUrl = json['twitter_url'];
//     metaTitle = json['meta_title'];
//     metaKeyword = json['meta_keyword'];
//     metaDescription = json['meta_description'];
//     isActive = json['is_active'];
//     isApproved = json['is_approved'];
//     isBlocked = json['is_blocked'];
//     createdDate = json['created_date'];
//     createdBy = json['created_by'];
//     modifiedDate = json['modified_date'];
//     modifiedBy = json['modified_by'];
//     dealsIn = json['deals_in'];
//     buyOrRent = json['buy_or_rent'];
//     rejectionDate = json['rejection_date'];
//     rejectionRemarks = json['rejection_remarks'];
//     deliveryMode = json['delivery_mode'];
//     cityLandmarkId = json['city_landmark_id'];
//     isActivePlan = json['is_active_plan'];
//     paymentModesAccepted = json['payment_modes_accepted'];
//     yearOfEstablishment = json['year_of_establishment'];
//     sellerCategory = json['seller_category'];
//     page = json['page'];
//     email = json['email'];
//     mobile = json['mobile'];
//     stateName = json['state_name'];
//     cityName = json['city_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['seller_id'] = sellerId;
//     data['user_id'] = userId;
//     data['store_name'] = storeName;
//     data['legal_business_name'] = legalBusinessName;
//     data['store_slug'] = storeSlug;
//     data['designation'] = designation;
//     data['store_description'] = storeDescription;
//     data['store_address'] = storeAddress;
//     data['store_loc_address'] = storeLocAddress;
//     data['landmark'] = landmark;
//     data['store_latitude'] = storeLatitude;
//     data['store_longitude'] = storeLongitude;
//     data['country_id'] = countryId;
//     data['state_id'] = stateId;
//     data['city_id'] = cityId;
//     data['pincode'] = pincode;
//     data['contact_no'] = contactNo;
//     data['contact_no_opt'] = contactNoOpt;
//     data['referral_code'] = referralCode;
//     data['sc_registration_type'] = scRegistrationType;
//     data['other_sc_reg_type'] = otherScRegType;
//     data['sc_registration_file'] = scRegistrationFile;
//     data['gst_no'] = gstNo;
//     data['store_logo_name'] = storeLogoName;
//     data['brochure_image'] = brochureImage;
//     data['store_banner_name'] = storeBannerName;
//     data['facebook_url'] = facebookUrl;
//     data['instagram_url'] = instagramUrl;
//     data['twitter_url'] = twitterUrl;
//     data['meta_title'] = metaTitle;
//     data['meta_keyword'] = metaKeyword;
//     data['meta_description'] = metaDescription;
//     data['is_active'] = isActive;
//     data['is_approved'] = isApproved;
//     data['is_blocked'] = isBlocked;
//     data['created_date'] = createdDate;
//     data['created_by'] = createdBy;
//     data['modified_date'] = modifiedDate;
//     data['modified_by'] = modifiedBy;
//     data['deals_in'] = dealsIn;
//     data['buy_or_rent'] = buyOrRent;
//     data['rejection_date'] = rejectionDate;
//     data['rejection_remarks'] = rejectionRemarks;
//     data['delivery_mode'] = deliveryMode;
//     data['city_landmark_id'] = cityLandmarkId;
//     data['is_active_plan'] = isActivePlan;
//     data['payment_modes_accepted'] = paymentModesAccepted;
//     data['year_of_establishment'] = yearOfEstablishment;
//     data['seller_category'] = sellerCategory;
//     data['page'] = page;
//     data['email'] = email;
//     data['mobile'] = mobile;
//     data['state_name'] = stateName;
//     data['city_name'] = cityName;
//     return data;
//   }
// }
//
// class MsubsData {
//   String? sellerSubscriptionId;
//   String? orderId;
//   String? sellerId;
//   String? subscriptionId;
//   PlanDetails? planDetails;
//   String? sbuscriptionStartDate;
//   String? sbuscriptionEndDate;
//   String? sbuscriptionDate;
//   String? isActive;
//   String? paymentStatus;
//   String? createdDate;
//   String? planType;
//   String? isEmi;
//   String? emiId;
//   String? emiCycle;
//   String? durationMonth;
//   String? paymentId;
//   String? isCouponApplied;
//   Null? couponCode;
//   String? planAmt;
//   String? orderAmt;
//   String? taxableAmt;
//   String? discountAmt;
//   String? existingPlanDiscount;
//   Null? taxAmt;
//   String? transactionAmt;
//   Null? transactionId;
//   Null? transactionDetails;
//   Null? couponDetails;
//   String? transactionStatus;
//   String? createdBy;
//   Null? invoiceNo;
//   Null? gstinNo;
//   String? cgst;
//   String? sgst;
//   String? igst;
//
//   MsubsData(
//       {this.sellerSubscriptionId,
//         this.orderId,
//         this.sellerId,
//         this.subscriptionId,
//         this.planDetails,
//         this.sbuscriptionStartDate,
//         this.sbuscriptionEndDate,
//         this.sbuscriptionDate,
//         this.isActive,
//         this.paymentStatus,
//         this.createdDate,
//         this.planType,
//         this.isEmi,
//         this.emiId,
//         this.emiCycle,
//         this.durationMonth,
//         this.paymentId,
//         this.isCouponApplied,
//         this.couponCode,
//         this.planAmt,
//         this.orderAmt,
//         this.taxableAmt,
//         this.discountAmt,
//         this.existingPlanDiscount,
//         this.taxAmt,
//         this.transactionAmt,
//         this.transactionId,
//         this.transactionDetails,
//         this.couponDetails,
//         this.transactionStatus,
//         this.createdBy,
//         this.invoiceNo,
//         this.gstinNo,
//         this.cgst,
//         this.sgst,
//         this.igst});
//
//   MsubsData.fromJson(Map<String, dynamic> json) {
//     sellerSubscriptionId = json['seller_subscription_id'];
//     orderId = json['order_id'];
//     sellerId = json['seller_id'];
//     subscriptionId = json['subscription_id'];
//     planDetails = json['plan_details'] != null
//         ? new PlanDetails.fromJson(json['plan_details'])
//         : null;
//     sbuscriptionStartDate = json['sbuscription_start_date'];
//     sbuscriptionEndDate = json['sbuscription_end_date'];
//     sbuscriptionDate = json['sbuscription_date'];
//     isActive = json['is_active'];
//     paymentStatus = json['payment_status'];
//     createdDate = json['created_date'];
//     planType = json['plan_type'];
//     isEmi = json['is_emi'];
//     emiId = json['emi_id'];
//     emiCycle = json['emi_cycle'];
//     durationMonth = json['duration_month'];
//     paymentId = json['payment_id'];
//     isCouponApplied = json['is_coupon_applied'];
//     couponCode = json['coupon_code'];
//     planAmt = json['plan_amt'];
//     orderAmt = json['order_amt'];
//     taxableAmt = json['taxable_amt'];
//     discountAmt = json['discount_amt'];
//     existingPlanDiscount = json['existing_plan_discount'];
//     taxAmt = json['tax_amt'];
//     transactionAmt = json['transaction_amt'];
//     transactionId = json['transaction_id'];
//     transactionDetails = json['transaction_details'];
//     couponDetails = json['coupon_details'];
//     transactionStatus = json['transaction_status'];
//     createdBy = json['created_by'];
//     invoiceNo = json['invoice_no'];
//     gstinNo = json['gstin_no'];
//     cgst = json['cgst'];
//     sgst = json['sgst'];
//     igst = json['igst'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['seller_subscription_id'] = sellerSubscriptionId;
//     data['order_id'] = orderId;
//     data['seller_id'] = sellerId;
//     data['subscription_id'] = subscriptionId;
//     if (planDetails != null) {
//       data['plan_details'] = planDetails!.toJson();
//     }
//     data['sbuscription_start_date'] = sbuscriptionStartDate;
//     data['sbuscription_end_date'] = sbuscriptionEndDate;
//     data['sbuscription_date'] = sbuscriptionDate;
//     data['is_active'] = isActive;
//     data['payment_status'] = paymentStatus;
//     data['created_date'] = createdDate;
//     data['plan_type'] = planType;
//     data['is_emi'] = isEmi;
//     data['emi_id'] = emiId;
//     data['emi_cycle'] = emiCycle;
//     data['duration_month'] = durationMonth;
//     data['payment_id'] = paymentId;
//     data['is_coupon_applied'] = isCouponApplied;
//     data['coupon_code'] = couponCode;
//     data['plan_amt'] = planAmt;
//     data['order_amt'] = orderAmt;
//     data['taxable_amt'] = taxableAmt;
//     data['discount_amt'] = discountAmt;
//     data['existing_plan_discount'] = existingPlanDiscount;
//     data['tax_amt'] = taxAmt;
//     data['transaction_amt'] = transactionAmt;
//     data['transaction_id'] = transactionId;
//     data['transaction_details'] = transactionDetails;
//     data['coupon_details'] = couponDetails;
//     data['transaction_status'] = transactionStatus;
//     data['created_by'] = createdBy;
//     data['invoice_no'] = invoiceNo;
//     data['gstin_no'] = gstinNo;
//     data['cgst'] = cgst;
//     data['sgst'] = sgst;
//     data['igst'] = igst;
//     return data;
//   }
// }
//
// class PlanDetails {
//   String? subscriptionId;
//   String? subscriptionName;
//   String? subscriptionDetails;
//   String? subscriptionPrice;
//   String? quarterlyPrice;
//   String? halfYearlyPrice;
//   String? yearlyPrice;
//   String? noOfProductAllowed;
//   String? wantToBuyLimit;
//   String? subscriptionValidity;
//   String? socialShareCitybazar;
//   Null? adBannerOfferAdda;
//   String? visitorAnalytics;
//   String? discountSection;
//   String? shopInFocus;
//   String? topProduct;
//   String? executeVisitUploads;
//   String? isActive;
//   String? isDeleted;
//   String? createdBy;
//   String? createdDate;
//   String? modifiedBy;
//   String? modifiedDate;
//   String? socialBoosting;
//
//   PlanDetails(
//       {this.subscriptionId,
//         this.subscriptionName,
//         this.subscriptionDetails,
//         this.subscriptionPrice,
//         this.quarterlyPrice,
//         this.halfYearlyPrice,
//         this.yearlyPrice,
//         this.noOfProductAllowed,
//         this.wantToBuyLimit,
//         this.subscriptionValidity,
//         this.socialShareCitybazar,
//         this.adBannerOfferAdda,
//         this.visitorAnalytics,
//         this.discountSection,
//         this.shopInFocus,
//         this.topProduct,
//         this.executeVisitUploads,
//         this.isActive,
//         this.isDeleted,
//         this.createdBy,
//         this.createdDate,
//         this.modifiedBy,
//         this.modifiedDate,
//         this.socialBoosting});
//
//   PlanDetails.fromJson(Map<String, dynamic> json) {
//     subscriptionId = json['subscription_id'];
//     subscriptionName = json['subscription_name'];
//     subscriptionDetails = json['subscription_details'];
//     subscriptionPrice = json['subscription_price'];
//     quarterlyPrice = json['quarterly_price'];
//     halfYearlyPrice = json['half_yearly_price'];
//     yearlyPrice = json['yearly_price'];
//     noOfProductAllowed = json['no_of_product_allowed'];
//     wantToBuyLimit = json['want_to_buy_limit'];
//     subscriptionValidity = json['subscription_validity'];
//     socialShareCitybazar = json['social_share_citybazar'];
//     adBannerOfferAdda = json['ad_banner_offer_adda'];
//     visitorAnalytics = json['visitor_analytics'];
//     discountSection = json['discount_section'];
//     shopInFocus = json['shop_in_focus'];
//     topProduct = json['top_product'];
//     executeVisitUploads = json['execute_visit_uploads'];
//     isActive = json['is_active'];
//     isDeleted = json['is_deleted'];
//     createdBy = json['created_by'];
//     createdDate = json['created_date'];
//     modifiedBy = json['modified_by'];
//     modifiedDate = json['modified_date'];
//     socialBoosting = json['social_boosting'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['subscription_id'] = subscriptionId;
//     data['subscription_name'] = subscriptionName;
//     data['subscription_details'] = subscriptionDetails;
//     data['subscription_price'] = subscriptionPrice;
//     data['quarterly_price'] = quarterlyPrice;
//     data['half_yearly_price'] = halfYearlyPrice;
//     data['yearly_price'] = yearlyPrice;
//     data['no_of_product_allowed'] = noOfProductAllowed;
//     data['want_to_buy_limit'] = wantToBuyLimit;
//     data['subscription_validity'] = subscriptionValidity;
//     data['social_share_citybazar'] = socialShareCitybazar;
//     data['ad_banner_offer_adda'] = adBannerOfferAdda;
//     data['visitor_analytics'] = visitorAnalytics;
//     data['discount_section'] = discountSection;
//     data['shop_in_focus'] = shopInFocus;
//     data['top_product'] = topProduct;
//     data['execute_visit_uploads'] = executeVisitUploads;
//     data['is_active'] = isActive;
//     data['is_deleted'] = isDeleted;
//     data['created_by'] = createdBy;
//     data['created_date'] = createdDate;
//     data['modified_by'] = modifiedBy;
//     data['modified_date'] = modifiedDate;
//     data['social_boosting'] = socialBoosting;
//     return data;
//   }
// }
//
// class CbDetails {
//   String? id;
//   String? sellerId;
//   String? orderId;
//   String? sellerName;
//   String? mobileNumber;
//   String? subscription;
//   String? cbPercenta;
//   String? partA;
//   String? partB;
//   String? partBMini;
//   String? partAMaxi;
//   String? cbLimitSelle;
//   String? maximumCash;
//   String? minimumUser;
//   String? maximumUser;
//   String? status;
//   String? isActive;
//   String? sbuscriptionStatus;
//   String? sbuscriptionEndDate;
//   String? insertDate;
//   String? updateDate;
//
//   CbDetails(
//       {this.id,
//         this.sellerId,
//         this.orderId,
//         this.sellerName,
//         this.mobileNumber,
//         this.subscription,
//         this.cbPercenta,
//         this.partA,
//         this.partB,
//         this.partBMini,
//         this.partAMaxi,
//         this.cbLimitSelle,
//         this.maximumCash,
//         this.minimumUser,
//         this.maximumUser,
//         this.status,
//         this.isActive,
//         this.sbuscriptionStatus,
//         this.sbuscriptionEndDate,
//         this.insertDate,
//         this.updateDate});
//
//   CbDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sellerId = json['seller_id'];
//     orderId = json['order_id'];
//     sellerName = json['seller_name'];
//     mobileNumber = json['mobile_number'];
//     subscription = json['subscription'];
//     cbPercenta = json['cb_percenta'];
//     partA = json['part_a'];
//     partB = json['part_b'];
//     partBMini = json['part_b_mini'];
//     partAMaxi = json['part_a_maxi'];
//     cbLimitSelle = json['cb_limit_selle'];
//     maximumCash = json['maximum_cash'];
//     minimumUser = json['minimum_user'];
//     maximumUser = json['maximum_user'];
//     status = json['status'];
//     isActive = json['is_active'];
//     sbuscriptionStatus = json['sbuscription_status'];
//     sbuscriptionEndDate = json['sbuscription_end_date'];
//     insertDate = json['insert_date'];
//     updateDate = json['update_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['seller_id'] = sellerId;
//     data['order_id'] = orderId;
//     data['seller_name'] = sellerName;
//     data['mobile_number'] = mobileNumber;
//     data['subscription'] = subscription;
//     data['cb_percenta'] = cbPercenta;
//     data['part_a'] = partA;
//     data['part_b'] = partB;
//     data['part_b_mini'] = partBMini;
//     data['part_a_maxi'] = partAMaxi;
//     data['cb_limit_selle'] = cbLimitSelle;
//     data['maximum_cash'] = maximumCash;
//     data['minimum_user'] = minimumUser;
//     data['maximum_user'] = maximumUser;
//     data['status'] = status;
//     data['is_active'] = isActive;
//     data['sbuscription_status'] = sbuscriptionStatus;
//     data['sbuscription_end_date'] = sbuscriptionEndDate;
//     data['insert_date'] = insertDate;
//     data['update_date'] = updateDate;
//     return data;
//   }
// }
