class BookedProductModel {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<BookedProductData>? data;

  BookedProductModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  BookedProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <BookedProductData>[];
      json['data'].forEach((v) {
        data!.add(BookedProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_pages'] = totalPages;
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

class BookedProductData {
  String? productId;
  String? productName;
  String? isDeleted;
  String? productSlug;
  String? model;
  String? price;
  String? productImgUrl;
  String? categoryName;
  String? createdDate;
  String? firstName;
  dynamic? lastName;
  String? mobile;
  String? email;

  BookedProductData(
      {this.productId,
        this.productName,
        this.isDeleted,
        this.productSlug,
        this.model,
        this.price,
        this.productImgUrl,
        this.categoryName,
        this.createdDate,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email});

  BookedProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    isDeleted = json['is_deleted'];
    productSlug = json['product_slug'];
    model = json['model'];
    price = json['price'];
    productImgUrl = json['product_img_url'];
    categoryName = json['category_name'];
    createdDate = json['created_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['is_deleted'] = isDeleted;
    data['product_slug'] = productSlug;
    data['model'] = model;
    data['price'] = price;
    data['product_img_url'] = productImgUrl;
    data['category_name'] = categoryName;
    data['created_date'] = createdDate;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
