class CompleteOrderListModel {
  String? status;
  int? totalPages;
  int? pageNo;
  String? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<CompleteOrderData>? data;
  Totalcount? totalcount;

  CompleteOrderListModel(
      {this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data,
        this.totalcount});

  CompleteOrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <CompleteOrderData>[];
      json['data'].forEach((v) {
        data!.add(CompleteOrderData.fromJson(v));
      });
    }
    totalcount = json['totalcount'] != null
        ? Totalcount.fromJson(json['totalcount'])
        : null;
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
    if (totalcount != null) {
      data['totalcount'] = totalcount!.toJson();
    }
    return data;
  }
}

class CompleteOrderData {
  String? totalPrice;
  String? productCount;
  String? createdDate;
  String? firstName;
  dynamic? lastName;
  String? mobile;
  String? userId;

  CompleteOrderData(
      {this.totalPrice,
        this.productCount,
        this.createdDate,
        this.firstName,
        this.lastName,
        this.mobile,
        this.userId});

  CompleteOrderData.fromJson(Map<String, dynamic> json) {
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

class Totalcount {
  String? userCount;
  String? totlaDealAmount;
  String? cashBackWon;
  dynamic? totalPrice;
  dynamic? productCount;

  Totalcount(
      {this.userCount,
        this.totlaDealAmount,
        this.cashBackWon,
        this.totalPrice,
        this.productCount});

  Totalcount.fromJson(Map<String, dynamic> json) {
    userCount = json['user_count'];
    totlaDealAmount = json['Totla_deal_amount'];
    cashBackWon = json['cash_back_won'];
    totalPrice = json['total_price'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_count'] = userCount;
    data['Totla_deal_amount'] = totlaDealAmount;
    data['cash_back_won'] = cashBackWon;
    data['total_price'] = totalPrice;
    data['product_count'] = productCount;
    return data;
  }
}
