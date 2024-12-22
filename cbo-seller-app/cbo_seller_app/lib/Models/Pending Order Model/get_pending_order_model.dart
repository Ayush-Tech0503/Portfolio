class PendingOrderModel {
  String? status;
  int? totalPages;
  String? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<PendingOrderData>? data;

  PendingOrderModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  PendingOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <PendingOrderData>[];
      json['data'].forEach((v) {
        data!.add(PendingOrderData.fromJson(v));
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

class PendingOrderData {
dynamic? totalPrice;
dynamic? productCount;
dynamic? createdDate;
dynamic? firstName;
dynamic? lastName;
dynamic? mobile;
dynamic? userId;

  PendingOrderData(
      {this.totalPrice,
        this.productCount,
        this.createdDate,
        this.firstName,
        this.lastName,
        this.mobile,
        this.userId});

  PendingOrderData.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'];
    productCount = json['product_count'];
    createdDate = json['created_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_price'] = totalPrice;
    data['product_count'] = productCount;
    data['created_date'] = createdDate;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['user_id'] = userId;
    return data;
  }
}

