class EMIOrderModel {
  String? status;
  String? orderId;
  String? authLink;

  EMIOrderModel({this.status, this.orderId, this.authLink});

  EMIOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['order_id'];
    authLink = json['authLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['order_id'] = orderId;
    data['authLink'] = authLink;
    return data;
  }
}
