class PendingOrderViewModel {
  String? status;
  List<PendingOrderViewData>? data;

  PendingOrderViewModel({this.status, this.data});

  PendingOrderViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PendingOrderViewData>[];
      json['data'].forEach((v) {
        data!.add(PendingOrderViewData.fromJson(v));
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

class PendingOrderViewData {
  String? productId;
  String? productName;
  String? productSlug;
  dynamic? offerPrice;
  String? price;
  String? imageFile;
  String? interestId;
  String? cartStatus;

  PendingOrderViewData(
      {this.productId,
        this.productName,
        this.productSlug,
        this.offerPrice,
        this.price,
        this.imageFile,
        this.interestId,
        this.cartStatus});

  PendingOrderViewData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    offerPrice = json['offer_price'];
    price = json['price'];
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
    data['image_file'] = imageFile;
    data['interest_id'] = interestId;
    data['cart_status'] = cartStatus;
    return data;
  }
}
