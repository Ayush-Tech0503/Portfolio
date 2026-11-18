class CardDetailsModel {
  dynamic? status;
  List<Data>? data;

  CardDetailsModel({this.status, this.data});

  CardDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  dynamic? sellerId;
  dynamic? storeName;
  dynamic? storeSlug;
  dynamic? contactNo;
  dynamic? deliveryMode;
  List<Cart>? cart;

  Data(
      {this.sellerId,
        this.storeName,
        this.storeSlug,
        this.contactNo,
        this.deliveryMode,
        this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    contactNo = json['contact_no'];
    deliveryMode = json['delivery_mode'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['contact_no'] = contactNo;
    data['delivery_mode'] = deliveryMode;
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  dynamic? productId;
  dynamic? productQuantity;
  dynamic? cartId;
  dynamic? userId;
  dynamic? sellerId;
  dynamic? insertDate;
  dynamic? productTitle;
  dynamic? productSlug;
  dynamic? price;
  dynamic? offerPrice;
  dynamic? productImage;

  Cart(
      {this.productId,
        this.productQuantity,
        this.cartId,
        this.userId,
        this.sellerId,
        this.insertDate,
        this.productTitle,
        this.productSlug,
        this.price,
        this.offerPrice,
        this.productImage});

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productQuantity = json['product_quantity'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    insertDate = json['insert_date'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    price = json['price'];
    offerPrice = json['offer_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_quantity'] = productQuantity;
    data['cart_id'] = cartId;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['insert_date'] = insertDate;
    data['product_title'] = productTitle;
    data['product_slug'] = productSlug;
    data['price'] = price;
    data['offer_price'] = offerPrice;
    data['product_image'] = productImage;
    return data;
  }
}
