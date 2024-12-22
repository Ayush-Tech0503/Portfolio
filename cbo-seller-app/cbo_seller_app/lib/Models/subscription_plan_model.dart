class SubscriptionPlanModel {
  String? status;
  SubscriptionPlanData? data;

  SubscriptionPlanModel({this.status, this.data});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SubscriptionPlanData.fromJson(json['data']) : null;
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

class SubscriptionPlanData {
  MsubsData? msubsData;
  List<AllSubsData>? allSubsData;
  // List<Null>? isEmi;

  SubscriptionPlanData({this.msubsData, this.allSubsData});

  SubscriptionPlanData.fromJson(Map<String, dynamic> json) {
    msubsData = json['msubs_data'] != null
        ? MsubsData.fromJson(json['msubs_data'])
        : null;
    if (json['all_subs_data'] != null) {
      allSubsData = <AllSubsData>[];
      json['all_subs_data'].forEach((v) {
        allSubsData!.add(AllSubsData.fromJson(v));
      });
    }
    // if (json['is_emi'] != null) {
    //   isEmi = <Null>[];
    //   json['is_emi'].forEach((v) {
    //     isEmi!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (msubsData != null) {
      data['msubs_data'] = msubsData!.toJson();
    }
    if (allSubsData != null) {
      data['all_subs_data'] = allSubsData!.map((v) => v.toJson()).toList();
    }
    // if (isEmi != null) {
    //   data['is_emi'] = isEmi!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class MsubsData {
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
  String? durationMonth;
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

  MsubsData(
      {this.sellerSubscriptionId,
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
        this.igst});

  MsubsData.fromJson(Map<String, dynamic> json) {
    sellerSubscriptionId = json['seller_subscription_id'];
    orderId = json['order_id'];
    sellerId = json['seller_id'];
    subscriptionId = json['subscription_id'];
    planDetails = json['plan_details'] != null
        ? PlanDetails.fromJson(json['plan_details'])
        : null;
    sbuscriptionStartDate = json['sbuscription_start_date'];
    sbuscriptionEndDate = json['sbuscription_end_date'];
    sbuscriptionDate = json['sbuscription_date'];
    isActive = json['is_active'];
    paymentStatus = json['payment_status'];
    createdDate = json['created_date'];
    planType = json['plan_type'];
    isEmi = json['is_emi'];
    emiId = json['emi_id'];
    emiCycle = json['emi_cycle'];
    durationMonth = json['duration_month'];
    paymentId = json['payment_id'];
    isCouponApplied = json['is_coupon_applied'];
    couponCode = json['coupon_code'];
    planAmt = json['plan_amt'];
    orderAmt = json['order_amt'];
    taxableAmt = json['taxable_amt'];
    discountAmt = json['discount_amt'];
    existingPlanDiscount = json['existing_plan_discount'];
    taxAmt = json['tax_amt'];
    transactionAmt = json['transaction_amt'];
    transactionId = json['transaction_id'];
    transactionDetails = json['transaction_details'];
    couponDetails = json['coupon_details'];
    transactionStatus = json['transaction_status'];
    createdBy = json['created_by'];
    invoiceNo = json['invoice_no'];
    gstinNo = json['gstin_no'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_subscription_id'] = sellerSubscriptionId;
    data['order_id'] = orderId;
    data['seller_id'] = sellerId;
    data['subscription_id'] = subscriptionId;
    if (planDetails != null) {
      data['plan_details'] = planDetails!.toJson();
    }
    data['sbuscription_start_date'] = sbuscriptionStartDate;
    data['sbuscription_end_date'] = sbuscriptionEndDate;
    data['sbuscription_date'] = sbuscriptionDate;
    data['is_active'] = isActive;
    data['payment_status'] = paymentStatus;
    data['created_date'] = createdDate;
    data['plan_type'] = planType;
    data['is_emi'] = isEmi;
    data['emi_id'] = emiId;
    data['emi_cycle'] = emiCycle;
    data['duration_month'] = durationMonth;
    data['payment_id'] = paymentId;
    data['is_coupon_applied'] = isCouponApplied;
    data['coupon_code'] = couponCode;
    data['plan_amt'] = planAmt;
    data['order_amt'] = orderAmt;
    data['taxable_amt'] = taxableAmt;
    data['discount_amt'] = discountAmt;
    data['existing_plan_discount'] = existingPlanDiscount;
    data['tax_amt'] = taxAmt;
    data['transaction_amt'] = transactionAmt;
    data['transaction_id'] = transactionId;
    data['transaction_details'] = transactionDetails;
    data['coupon_details'] = couponDetails;
    data['transaction_status'] = transactionStatus;
    data['created_by'] = createdBy;
    data['invoice_no'] = invoiceNo;
    data['gstin_no'] = gstinNo;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['igst'] = igst;
    return data;
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

  PlanDetails(
      {this.subscriptionId,
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
        this.socialBoosting});

  PlanDetails.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    subscriptionName = json['subscription_name'];
    subscriptionDetails = json['subscription_details'];
    subscriptionPrice = json['subscription_price'];
    quarterlyPrice = json['quarterly_price'];
    halfYearlyPrice = json['half_yearly_price'];
    yearlyPrice = json['yearly_price'];
    noOfProductAllowed = json['no_of_product_allowed'];
    wantToBuyLimit = json['want_to_buy_limit'];
    subscriptionValidity = json['subscription_validity'];
    socialShareCitybazar = json['social_share_citybazar'];
    adBannerOfferAdda = json['ad_banner_offer_adda'];
    visitorAnalytics = json['visitor_analytics'];
    discountSection = json['discount_section'];
    shopInFocus = json['shop_in_focus'];
    topProduct = json['top_product'];
    executeVisitUploads = json['execute_visit_uploads'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    modifiedBy = json['modified_by'];
    modifiedDate = json['modified_date'];
    socialBoosting = json['social_boosting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscription_id'] = subscriptionId;
    data['subscription_name'] = subscriptionName;
    data['subscription_details'] = subscriptionDetails;
    data['subscription_price'] = subscriptionPrice;
    data['quarterly_price'] = quarterlyPrice;
    data['half_yearly_price'] = halfYearlyPrice;
    data['yearly_price'] = yearlyPrice;
    data['no_of_product_allowed'] = noOfProductAllowed;
    data['want_to_buy_limit'] = wantToBuyLimit;
    data['subscription_validity'] = subscriptionValidity;
    data['social_share_citybazar'] = socialShareCitybazar;
    data['ad_banner_offer_adda'] = adBannerOfferAdda;
    data['visitor_analytics'] = visitorAnalytics;
    data['discount_section'] = discountSection;
    data['shop_in_focus'] = shopInFocus;
    data['top_product'] = topProduct;
    data['execute_visit_uploads'] = executeVisitUploads;
    data['is_active'] = isActive;
    data['is_deleted'] = isDeleted;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['modified_by'] = modifiedBy;
    data['modified_date'] = modifiedDate;
    data['social_boosting'] = socialBoosting;
    return data;
  }
}

class AllSubsData {
  String? sellerSubscriptionId;
  String? orderId;
  String? sellerId;
  String? subscriptionId;
  String? planDetails;
  String? sbuscriptionStartDate;
  String? sellerInvoice;
  String? sbuscriptionEndDate;
  String? sbuscriptionDate;
  String? isActive;
  String? paymentStatus;
  String? createdDate;
  String? planType;
  String? isEmi;
  String? emiId;
  String? emiCycle;
  String? durationMonth;
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

  AllSubsData(
      {this.sellerSubscriptionId,
        this.orderId,
        this.sellerId,
        this.subscriptionId,
        this.planDetails,
        this.sbuscriptionStartDate,
        this.sbuscriptionEndDate,
        this.sbuscriptionDate,
        this.sellerInvoice,
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
        this.igst});

  AllSubsData.fromJson(Map<String, dynamic> json) {
    sellerSubscriptionId = json['seller_subscription_id'];
    orderId = json['order_id'];
    sellerId = json['seller_id'];
    subscriptionId = json['subscription_id'];
    planDetails = json['plan_details'];
    sbuscriptionStartDate = json['sbuscription_start_date'];
    sbuscriptionEndDate = json['sbuscription_end_date'];
    sbuscriptionDate = json['sbuscription_date'];
    isActive = json['is_active'];
    paymentStatus = json['payment_status'];
    createdDate = json['created_date'];
    planType = json['plan_type'];
    sellerInvoice = json['seller_invoice'];
    isEmi = json['is_emi'];
    emiId = json['emi_id'];
    emiCycle = json['emi_cycle'];
    durationMonth = json['duration_month'];
    paymentId = json['payment_id'];
    isCouponApplied = json['is_coupon_applied'];
    couponCode = json['coupon_code'];
    planAmt = json['plan_amt'];
    orderAmt = json['order_amt'];
    taxableAmt = json['taxable_amt'];
    discountAmt = json['discount_amt'];
    existingPlanDiscount = json['existing_plan_discount'];
    taxAmt = json['tax_amt'];
    transactionAmt = json['transaction_amt'];
    transactionId = json['transaction_id'];
    transactionDetails = json['transaction_details'];
    couponDetails = json['coupon_details'];
    transactionStatus = json['transaction_status'];
    createdBy = json['created_by'];
    invoiceNo = json['invoice_no'];
    gstinNo = json['gstin_no'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_subscription_id'] = sellerSubscriptionId;
    data['order_id'] = orderId;
    data['seller_id'] = sellerId;
    data['subscription_id'] = subscriptionId;
    data['plan_details'] = planDetails;
    data['sbuscription_start_date'] = sbuscriptionStartDate;
    data['sbuscription_end_date'] = sbuscriptionEndDate;
    data['sbuscription_date'] = sbuscriptionDate;
    data['is_active'] = isActive;
    data['payment_status'] = paymentStatus;
    data['created_date'] = createdDate;
    data['plan_type'] = planType;
    data['is_emi'] = isEmi;
    data['emi_id'] = emiId;
    data['emi_cycle'] = emiCycle;
    data['seller_invoice'] = sellerInvoice;
    data['duration_month'] = durationMonth;
    data['payment_id'] = paymentId;
    data['is_coupon_applied'] = isCouponApplied;
    data['coupon_code'] = couponCode;
    data['plan_amt'] = planAmt;
    data['order_amt'] = orderAmt;
    data['taxable_amt'] = taxableAmt;
    data['discount_amt'] = discountAmt;
    data['existing_plan_discount'] = existingPlanDiscount;
    data['tax_amt'] = taxAmt;
    data['transaction_amt'] = transactionAmt;
    data['transaction_id'] = transactionId;
    data['transaction_details'] = transactionDetails;
    data['coupon_details'] = couponDetails;
    data['transaction_status'] = transactionStatus;
    data['created_by'] = createdBy;
    data['invoice_no'] = invoiceNo;
    data['gstin_no'] = gstinNo;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['igst'] = igst;
    return data;
  }
}
