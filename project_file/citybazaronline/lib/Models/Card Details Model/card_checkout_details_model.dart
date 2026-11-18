class CheckOutCartModel {
  dynamic? status;
  List<CheckOutCartData>? data;
  List<Address>? address;

  CheckOutCartModel({this.status, this.data, this.address});

  CheckOutCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CheckOutCartData>[];
      json['data'].forEach((v) {
        data!.add(CheckOutCartData.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckOutCartData {
  dynamic? sellerId;
  dynamic? storeName;
  dynamic? storeSlug;
  dynamic? contactNo;
  dynamic? deliveryMode;
  List<Cart>? cart;

  CheckOutCartData(
      {this.sellerId,
        this.storeName,
        this.storeSlug,
        this.contactNo,
        this.deliveryMode,
        this.cart});

  CheckOutCartData.fromJson(Map<String, dynamic> json) {
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

class Address {
  dynamic? addressId;
  dynamic? address;
  dynamic? city;
  dynamic? state;
  dynamic? country;
  dynamic? pincode;
  dynamic? addressType;
  dynamic? deflate;
  dynamic? insertDate;
  dynamic? landmark;
  dynamic? houseNumber;
  dynamic? userId;

  Address(
      {this.addressId,
        this.address,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.addressType,
        this.deflate,
        this.insertDate,
        this.landmark,
        this.houseNumber,
        this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    addressType = json['address_type'];
    deflate = json['deflate'];
    insertDate = json['insert_date'];
    landmark = json['landmark'];
    houseNumber = json['house_number'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    data['address_type'] = addressType;
    data['deflate'] = deflate;
    data['insert_date'] = insertDate;
    data['landmark'] = landmark;
    data['house_number'] = houseNumber;
    data['user_id'] = userId;
    return data;
  }
}
