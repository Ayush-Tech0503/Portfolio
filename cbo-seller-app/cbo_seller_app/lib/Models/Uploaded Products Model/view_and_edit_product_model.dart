class ViewProductModel {
  dynamic status;
  List<ProductDetails>? productDetails;
  dynamic msg;

  ViewProductModel({this.status, this.productDetails, this.msg});

  ViewProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(ProductDetails.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (productDetails != null) {
      data['product_details'] =
          productDetails!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class ProductDetails {
  dynamic categoryName;
  dynamic isRestricted;
  dynamic productId;
  dynamic productReferenceId;
  dynamic variantGroupId;
  dynamic imgGroupId;
  dynamic sku;
  dynamic productName;
  dynamic productSlug;
  dynamic model;
  dynamic brand;
  dynamic price;
  dynamic offerPrice;
  dynamic offerStartDate;
  dynamic offerEndDate;
  dynamic stockQuantity;
  dynamic isAvailable;
  dynamic productCategory;
  dynamic isActive;
  dynamic isApproved;
  dynamic isDeleted;
  dynamic rejectionDate;
  dynamic rejectionRemarks;
  dynamic createdDate;
  dynamic createdBy;
  dynamic employeeId;
  dynamic modifiedDate;
  dynamic modifiedBy;
  dynamic prodUrl;
  dynamic isDisabled;
  dynamic sellerId;
  dynamic warranty;
  dynamic description;
  dynamic shortDescription;
  dynamic otherFeature;
  dynamic productImageId;
  dynamic imageFile;
  dynamic isPrimary;
  dynamic imageOrder;
  dynamic productStatus;

  ProductDetails(
      {this.categoryName,
        this.isRestricted,
        this.productId,
        this.productReferenceId,
        this.variantGroupId,
        this.imgGroupId,
        this.sku,
        this.productName,
        this.productSlug,
        this.model,
        this.brand,
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
        this.employeeId,
        this.modifiedDate,
        this.modifiedBy,
        this.prodUrl,
        this.isDisabled,
        this.sellerId,
        this.warranty,
        this.description,
        this.shortDescription,
        this.otherFeature,
        this.productImageId,
        this.imageFile,
        this.isPrimary,
        this.imageOrder,
        this.productStatus});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    isRestricted = json['is_restricted'];
    productId = json['product_id'];
    productReferenceId = json['product_reference_id'];
    variantGroupId = json['variant_group_id'];
    imgGroupId = json['img_group_id'];
    sku = json['sku'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    model = json['model'];
    brand = json['brand'];
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
    employeeId = json['employee_id'];
    modifiedDate = json['modified_date'];
    modifiedBy = json['modified_by'];
    prodUrl = json['prod_url'];
    isDisabled = json['is_disabled'];
    sellerId = json['seller_id'];
    warranty = json['warranty'];
    description = json['description'];
    shortDescription = json['short_description'];
    otherFeature = json['other_feature'];
    productImageId = json['product_image_id'];
    imageFile = json['image_file'];
    isPrimary = json['is_primary'];
    imageOrder = json['image_order'];
    productStatus = json['product_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_name'] = categoryName;
    data['is_restricted'] = isRestricted;
    data['product_id'] = productId;
    data['product_reference_id'] = productReferenceId;
    data['variant_group_id'] = variantGroupId;
    data['img_group_id'] = imgGroupId;
    data['sku'] = sku;
    data['product_name'] = productName;
    data['product_slug'] = productSlug;
    data['model'] = model;
    data['brand'] = brand;
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
    data['employee_id'] = employeeId;
    data['modified_date'] = modifiedDate;
    data['modified_by'] = modifiedBy;
    data['prod_url'] = prodUrl;
    data['is_disabled'] = isDisabled;
    data['seller_id'] = sellerId;
    data['warranty'] = warranty;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['other_feature'] = otherFeature;
    data['product_image_id'] = productImageId;
    data['image_file'] = imageFile;
    data['is_primary'] = isPrimary;
    data['image_order'] = imageOrder;
    data['product_status'] = productStatus;
    return data;
  }
}
