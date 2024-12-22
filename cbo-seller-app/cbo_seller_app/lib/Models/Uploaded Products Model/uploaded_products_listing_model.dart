class UploadedProductListModel {
  String? status;
  int? totalPages;
  String? productAddButton;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<UploadedProductListData>? data;

  UploadedProductListModel(
      {this.status,
        this.totalPages,
        this.productAddButton,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  UploadedProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    productAddButton = json['product_add_button'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <UploadedProductListData>[];
      json['data'].forEach((v) {
        data!.add(UploadedProductListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_pages'] = totalPages;
    data['product_add_button'] = productAddButton;
    data['page_no'] = pageNo;
    data['limit'] = limit;
    data['offset'] = offset;
    data['count'] = count;
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UploadedProductListData {
  String? productId;
  String? productName;
  String? model;
  String? price;
  String? offerPrice;
  String? stockQuantity;
  String? isActive;
  String? isApproved;
  String? categoryName;
  String? isRestricted;
  String? productImgUrl;
  String? brand;
  String? createdBy;
  // bool? selectedCheckBox =  false;
  dynamic? rejectionRemarks;
  dynamic? rejectionDate;
  String? createdDate;
  String? modifiedDate;
  String? showDate;
  dynamic? topProductsIsActive;
  dynamic? isDefault;

  UploadedProductListData(
      {this.productId,
        this.productName,
        this.model,
        this.price,
        this.offerPrice,
        this.stockQuantity,
        this.isActive,
        this.isApproved,
        this.categoryName,
        this.isRestricted,
        this.productImgUrl,
        this.brand,
        this.createdBy,
        this.rejectionRemarks,
        this.rejectionDate,
        // this.selectedCheckBox,
        this.createdDate,
        this.modifiedDate,
        this.showDate,
        this.topProductsIsActive,
        this.isDefault});

  UploadedProductListData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    model = json['model'];
    price = json['price'];
    offerPrice = json['offer_price'];
    stockQuantity = json['stock_quantity'];
    isActive = json['is_active'];
    isApproved = json['is_approved'];
    categoryName = json['category_name'];
    isRestricted = json['is_restricted'];
    productImgUrl = json['product_img_url'];
    brand = json['brand'];
    createdBy = json['created_by'];
    rejectionRemarks = json['rejection_remarks'];
    rejectionDate = json['rejection_date'];
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
    showDate = json['show_date'];
    topProductsIsActive = json['top_products_is_active'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['model'] = model;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['stock_quantity'] = stockQuantity;
    data['is_active'] = isActive;
    data['is_approved'] = isApproved;
    data['category_name'] = categoryName;
    data['is_restricted'] = isRestricted;
    data['product_img_url'] = productImgUrl;
    data['brand'] = brand;
    data['created_by'] = createdBy;
    data['rejection_remarks'] = rejectionRemarks;
    data['rejection_date'] = rejectionDate;
    data['created_date'] = createdDate;
    data['modified_date'] = modifiedDate;
    data['show_date'] = showDate;
    data['top_products_is_active'] = topProductsIsActive;
    data['is_default'] = isDefault;
    return data;
  }
}
