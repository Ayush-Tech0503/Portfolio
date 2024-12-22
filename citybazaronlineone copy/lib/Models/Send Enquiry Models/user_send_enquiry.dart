class SendEnquiry {
  SendEnquiry({
     this.status,
    this.sms,
     this.msg,
    this.sellerMobile,
     this.userMobile,
  });
     String? status;
     String? sms;
     String? msg;
     String? sellerMobile;
     String? userMobile;

  SendEnquiry.fromJson(Map<String, dynamic> json){
    status = json['status'];
    sms = json['sms'];
    msg = json['msg'];
    sellerMobile = json['seller_mobile'];
    userMobile = json['user_mobile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['sms'] = sms;
    data['msg'] = msg;
    data['seller_mobile'] = sellerMobile;
    data['user_mobile'] = userMobile;
    return data;
  }
}