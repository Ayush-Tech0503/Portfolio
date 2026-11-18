class LikedProductData {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<LikedProductList>? data;

  LikedProductData(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  LikedProductData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <LikedProductList>[];
      json['data'].forEach((v) {
        data!.add(LikedProductList.fromJson(v));
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

class LikedProductList {
  String? productId;
  String? productName;
  String? productSlug;
  String? model;
  String? price;
  String? brand;
  String? imageFile;
  String? categoryName;
  String? isDeleted;
  String? productImgUrl;
  String? delid;
  String? storeName;
  String? storeSlug;
  String? cloneProductId;

  LikedProductList(
      {this.productId,
        this.productName,
        this.productSlug,
        this.model,
        this.price,
        this.brand,
        this.imageFile,
        this.categoryName,
        this.isDeleted,
        this.productImgUrl,
        this.delid,
        this.storeName,
        this.storeSlug,
        this.cloneProductId});

  LikedProductList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    model = json['model'];
    price = json['price'];
    brand = json['brand'];
    imageFile = json['image_file'];
    categoryName = json['category_name'];
    isDeleted = json['is_deleted'];
    productImgUrl = json['product_img_url'];
    delid = json['delid'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    cloneProductId = json['clone_product_id'];
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
    data['is_deleted'] = isDeleted;
    data['product_img_url'] = productImgUrl;
    data['delid'] = delid;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['clone_product_id'] = cloneProductId;
    return data;
  }
}
