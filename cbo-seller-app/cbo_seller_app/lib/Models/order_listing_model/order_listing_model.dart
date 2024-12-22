class OderListingModel {
  String? status;
  List<OderListingData>? data;

  OderListingModel({this.status, this.data});

  OderListingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OderListingData>[];
      json['data'].forEach((v) {
        data!.add(OderListingData.fromJson(v));
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

class OderListingData {
  String? orderId;
  String? userId;
  String? sellerId;
  String? addressId;
  String? orderStatus;
  String? insertDate;
  String? updateDate;
  String? storeId;
  String? deliveryMode;
  String? storeName;
  String? storeSlug;
  String? contactNo;
  String? storeAddress;
  String? userName;
  String? userMobile;
  String? statusText;
  String? statusMessage;
  List<Product>? product;

  OderListingData(
      {this.orderId,
        this.userId,
        this.sellerId,
        this.addressId,
        this.orderStatus,
        this.insertDate,
        this.updateDate,
        this.storeId,
        this.deliveryMode,
        this.storeName,
        this.storeSlug,
        this.contactNo,
        this.storeAddress,
        this.userName,
        this.userMobile,
        this.statusText,
        this.statusMessage,
        this.product});

  OderListingData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    addressId = json['address_id'];
    orderStatus = json['order_status'];
    insertDate = json['insert_date'];
    updateDate = json['update_date'];
    storeId = json['store_id'];
    deliveryMode = json['delivery_mode'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    storeAddress = json['store_address'];
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    statusText = json['status_text'];
    statusMessage = json['status_message'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['address_id'] = addressId;
    data['order_status'] = orderStatus;
    data['insert_date'] = insertDate;
    data['update_date'] = updateDate;
    data['store_id'] = storeId;
    data['delivery_mode'] = deliveryMode;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['store_address'] = storeAddress;
    data['user_name'] = userName;
    data['user_mobile'] = userMobile;
    data['status_text'] = statusText;
    data['status_message'] = statusMessage;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? orderDetailId;
  String? orderId;
  String? productId;
  String? productQuantity;
  String? price;
  String? offerPrice;
  String? productTitle;
  String? insertDate;
  String? productImage;

  Product(
      {this.orderDetailId,
        this.orderId,
        this.productId,
        this.productQuantity,
        this.price,
        this.offerPrice,
        this.productTitle,
        this.insertDate,
        this.productImage});

  Product.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['order_detail_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productQuantity = json['product_quantity'];
    price = json['price'];
    offerPrice = json['offer_price'];
    productTitle = json['product_title'];
    insertDate = json['insert_date'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_detail_id'] = orderDetailId;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_quantity'] = productQuantity;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['product_title'] = productTitle;
    data['insert_date'] = insertDate;
    data['product_image'] = productImage;
    return data;
  }
}
