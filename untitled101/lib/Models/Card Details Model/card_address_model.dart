class CardAddressModel {
  dynamic? status;
  List<CardAddressData>? data;

  CardAddressModel({this.status, this.data});

  CardAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CardAddressData>[];
      json['data'].forEach((v) {
        data!.add(CardAddressData.fromJson(v));
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

class CardAddressData {
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

  CardAddressData(
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

  CardAddressData.fromJson(Map<String, dynamic> json) {
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
