class SubscriptionPlanListModels {
  String? status;
  List<PlanListData>? data;

  SubscriptionPlanListModels({this.status, this.data});

  SubscriptionPlanListModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PlanListData>[];
      json['data'].forEach((v) {
        data!.add(PlanListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanListData {
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
  String? isEmi;
  String? noOfReelAllowed;
  String? planDiscount;

  PlanListData(
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
        this.socialBoosting,
        this.isEmi,
        this.noOfReelAllowed,
        this.planDiscount});

  PlanListData.fromJson(Map<String, dynamic> json) {
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
    isEmi = json['is_emi'];
    noOfReelAllowed = json['no_of_reel_allowed'];
    planDiscount = json['plan_discount'];
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
    data['is_emi'] = isEmi;
    data['no_of_reel_allowed'] = noOfReelAllowed;
    data['plan_discount'] = planDiscount;
    return data;
  }
}
