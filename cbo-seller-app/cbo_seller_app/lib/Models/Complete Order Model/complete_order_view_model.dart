class CompleteOrderViewModel {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<CompleteOrderViewData>? data;

  CompleteOrderViewModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  CompleteOrderViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <CompleteOrderViewData>[];
      json['data'].forEach((v) {
        data!.add(CompleteOrderViewData.fromJson(v));
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

class CompleteOrderViewData {
  String? productId;
  String? productName;
  String? productSlug;
  String? offerPrice;
  String? price;
  dynamic? dealPrice;
  String? imageFile;
  String? interestId;
  String? cartStatus;

  CompleteOrderViewData(
      {this.productId,
        this.productName,
        this.productSlug,
        this.offerPrice,
        this.price,
        this.dealPrice,
        this.imageFile,
        this.interestId,
        this.cartStatus});

  CompleteOrderViewData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    offerPrice = json['offer_price'];
    price = json['price'];
    dealPrice = json['deal_price'];
    imageFile = json['image_file'];
    interestId = json['interest_id'];
    cartStatus = json['cart_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_slug'] = productSlug;
    data['offer_price'] = offerPrice;
    data['price'] = price;
    data['deal_price'] = dealPrice;
    data['image_file'] = imageFile;
    data['interest_id'] = interestId;
    data['cart_status'] = cartStatus;
    return data;
  }
}
