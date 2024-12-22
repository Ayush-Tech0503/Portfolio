class BrandListModel {
  String? status;
  List<BrandListData>? data;

  BrandListModel({this.status, this.data});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BrandListData>[];
      json['data'].forEach((v) {
        data!.add(BrandListData.fromJson(v));
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

class BrandListData {
  String? brand;

  BrandListData({this.brand});

  BrandListData.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    return data;
  }
}
