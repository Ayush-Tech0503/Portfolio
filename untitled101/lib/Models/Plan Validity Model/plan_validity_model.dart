class PlanValidityModel {
  dynamic? status;
  bool? planeValidity;
  List<PlanValidityData>? data;

  PlanValidityModel({this.status, this.planeValidity, this.data});

  PlanValidityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    planeValidity = json['planeValidity '];
    if (json['data'] != null) {
      data = <PlanValidityData>[];
      json['data'].forEach((v) {
        data!.add(PlanValidityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['planeValidity '] = planeValidity;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanValidityData {
  dynamic? storeName;
  dynamic? storeSlug;
  dynamic? storeAddress;
  dynamic? contactNo;

  PlanValidityData({this.storeName, this.storeSlug, this.storeAddress, this.contactNo});

  PlanValidityData.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeAddress = json['store_address'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_name'] = storeName;
    data['store_slug'] = storeSlug;
    data['store_address'] = storeAddress;
    data['contact_no'] = contactNo;
    return data;
  }
}
