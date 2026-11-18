class OrderListModel {
  dynamic? status;
  List<OrderListData>? data;

  OrderListModel({this.status, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderListData>[];
      json['data'].forEach((v) {
        data!.add(OrderListData.fromJson(v));
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

class OrderListData {
  dynamic? orderId;
  dynamic? userId;
  dynamic? sellerId;
  dynamic? addressId;
  dynamic? storeAddress;
  dynamic? statusText;
  dynamic? statusMessage;
  dynamic? orderStatus;
  dynamic? insertDate;
  dynamic?storeId;
  dynamic? updateDate;
  dynamic? deliveryMode;
  dynamic? storeName;
  dynamic? storeSlug;
  dynamic? contactNo;
  List<Product>? product;

  OrderListData(
      {this.orderId,
        this.userId,
        this.sellerId,
        this.addressId,
        this.orderStatus,
        this.storeAddress,
        this.statusMessage,
        this.statusText,
        this.insertDate,
        this.updateDate,
        this.storeId,
        this.deliveryMode,
        this.storeName,
        this.storeSlug,
        this.contactNo,
        this.product});

  OrderListData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    addressId = json['address_id'];
    storeId = json['store_id'];
    orderStatus = json['order_status'];
    storeAddress = json['store_address'];
    statusMessage = json['status_message'];
    statusText = json['status_text'];
    insertDate = json['insert_date'];
    updateDate = json['update_date'];
    deliveryMode = json['delivery_mode'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
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
    data['store_id'] = storeId;
    data['address_id'] = addressId;
    data['status_message'] = statusMessage;
    data['store_address'] = storeAddress;
    data['status_text'] = statusText;
    data['order_status'] = orderStatus;
    data['insert_date'] = insertDate;
    data['update_date'] = updateDate;
    data['delivery_mode'] = deliveryMode;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  dynamic? orderDetailId;
  dynamic? orderId;
  dynamic? productId;
  dynamic? productQuantity;
  dynamic? price;
  dynamic? offerPrice;
  dynamic? productTitle;
  dynamic? insertDate;
  dynamic? productImage;

  Product(
      {this.orderDetailId,
        this.orderId,
        this.productId,
        this.productQuantity,
        this.price,
        this.offerPrice,
        this.productTitle,
        this.insertDate,
        this.productImage
      });

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
