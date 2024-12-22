class BookedDataModel {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<BookedDataList>? data;

  BookedDataModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  BookedDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <BookedDataList>[];
      json['data'].forEach((v) {
        data!.add(BookedDataList.fromJson(v));
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

class BookedDataList {
  String? productId;
  String? productName;
  String? productSlug;
  String? model;
  String? price;
  String? brand;
  String? imageFile;
  String? categoryName;
  String? productImgUrl;
  String? delid;
  String? storeName;
  String? storeSlug;
  String? cityId;
  String? isDeleted;
  String? createdDate;

  BookedDataList(
      {this.productId,
        this.productName,
        this.productSlug,
        this.model,
        this.price,
        this.brand,
        this.imageFile,
        this.categoryName,
        this.productImgUrl,
        this.delid,
        this.storeName,
        this.storeSlug,
        this.cityId,
        this.isDeleted,
        this.createdDate});

  BookedDataList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    model = json['model'];
    price = json['price'];
    brand = json['brand'];
    imageFile = json['image_file'];
    categoryName = json['category_name'];
    productImgUrl = json['product_img_url'];
    delid = json['delid'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    cityId = json['city_id'];
    isDeleted = json['is_deleted'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_slug'] = productSlug;
    data['model'] = model;
    data['price'] = price;
    data['brand'] = brand;
    data['image_file'] = imageFile;
    data['category_name'] = categoryName;
    data['product_img_url'] = productImgUrl;
    data['delid'] = delid;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['city_id'] = cityId;
    data['is_deleted'] = isDeleted;
    data['created_date'] = createdDate;
    return data;
  }
}
