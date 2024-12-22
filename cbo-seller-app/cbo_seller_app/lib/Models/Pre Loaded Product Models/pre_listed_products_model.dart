class PreListedProductModel {
  String? status;
  List<PreListedProductData>? data;

  PreListedProductModel({this.status, this.data});

  PreListedProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PreListedProductData>[];
      json['data'].forEach((v) {
        data!.add(PreListedProductData.fromJson(v));
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

class PreListedProductData {
  bool? selectedCheck;
  String? productId;
  String? variantGroupId;
  String? imgGroupId;
  String? sku;
  String? productName;
  String? productSlug;
  String? model;
  String? price;
  dynamic? offerPrice;
  dynamic? offerStartDate;
  dynamic? offerEndDate;
  String? stockQuantity;
  String? isAvailable;
  String? productCategory;
  String? isActive;
  String? isApproved;
  String? isDeleted;
  dynamic? rejectionDate;
  dynamic? rejectionRemarks;
  String? createdDate;
  String? createdBy;
  dynamic? modifiedDate;
  dynamic? modifiedBy;
  String? brand;
  dynamic? prodUrl;
  dynamic? productReferenceId;
  String? imageFile;

  PreListedProductData(
      {this.productId,
        this.variantGroupId,
        this.selectedCheck,
        this.imgGroupId,
        this.sku,
        this.productName,
        this.productSlug,
        this.model,
        this.price,
        this.offerPrice,
        this.offerStartDate,
        this.offerEndDate,
        this.stockQuantity,
        this.isAvailable,
        this.productCategory,
        this.isActive,
        this.isApproved,
        this.isDeleted,
        this.rejectionDate,
        this.rejectionRemarks,
        this.createdDate,
        this.createdBy,
        this.modifiedDate,
        this.modifiedBy,
        this.brand,
        this.prodUrl,
        this.productReferenceId,
        this.imageFile});

  PreListedProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    selectedCheck = json['selectedCheck'];
    variantGroupId = json['variant_group_id'];
    imgGroupId = json['img_group_id'];
    sku = json['sku'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    model = json['model'];
    price = json['price'];
    offerPrice = json['offer_price'];
    offerStartDate = json['offer_start_date'];
    offerEndDate = json['offer_end_date'];
    stockQuantity = json['stock_quantity'];
    isAvailable = json['is_available'];
    productCategory = json['product_category'];
    isActive = json['is_active'];
    isApproved = json['is_approved'];
    isDeleted = json['is_deleted'];
    rejectionDate = json['rejection_date'];
    rejectionRemarks = json['rejection_remarks'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    modifiedDate = json['modified_date'];
    modifiedBy = json['modified_by'];
    brand = json['brand'];
    prodUrl = json['prod_url'];
    productReferenceId = json['product_reference_id'];
    imageFile = json['image_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['selectedCheck'] = selectedCheck;
    data['variant_group_id'] = variantGroupId;
    data['img_group_id'] = imgGroupId;
    data['sku'] = sku;
    data['product_name'] = productName;
    data['product_slug'] = productSlug;
    data['model'] = model;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['offer_start_date'] = offerStartDate;
    data['offer_end_date'] = offerEndDate;
    data['stock_quantity'] = stockQuantity;
    data['is_available'] = isAvailable;
    data['product_category'] = productCategory;
    data['is_active'] = isActive;
    data['is_approved'] = isApproved;
    data['is_deleted'] = isDeleted;
    data['rejection_date'] = rejectionDate;
    data['rejection_remarks'] = rejectionRemarks;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['modified_date'] = modifiedDate;
    data['modified_by'] = modifiedBy;
    data['brand'] = brand;
    data['prod_url'] = prodUrl;
    data['product_reference_id'] = productReferenceId;
    data['image_file'] = imageFile;
    return data;
  }
}
