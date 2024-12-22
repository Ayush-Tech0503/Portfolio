class CouponsModel {
  dynamic success;
  dynamic extPlanDis;
  dynamic discountVal;
  dynamic payAmt;
  dynamic tax;
  dynamic totalAmt;
  dynamic status;

  CouponsModel(
      {this.success,
        this.extPlanDis,
        this.discountVal,
        this.payAmt,
        this.tax,
        this.totalAmt,
        this.status});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    extPlanDis = json['ext_plan_dis'];
    discountVal = json['discount_val'];
    payAmt = json['pay_amt'];
    tax = json['tax'];
    totalAmt = json['total_amt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['ext_plan_dis'] = extPlanDis;
    data['discount_val'] = discountVal;
    data['pay_amt'] = payAmt;
    data['tax'] = tax;
    data['total_amt'] = totalAmt;
    data['status'] = status;
    return data;
  }
}
