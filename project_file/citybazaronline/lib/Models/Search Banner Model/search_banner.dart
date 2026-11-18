class SearchBannerData {
  SearchBannerData({
    this.data,
    this.status,
  });

  List<Data>? data;
  String? status;

  SearchBannerData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = (json['data'] as List).map((e) => Data.fromJson(e)).toList();
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    if (data != null) {
      _data['data'] = data!.map((e) => e.toJson()).toList();
    }
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    this.bannerImage,
    this.type,
    this.whatsapptext,
    this.keyword,
    this.bannerTitle,
    this.discount,
  });

  String? bannerImage;
  String? type;
  String? whatsapptext;
  String? keyword;
  String? bannerTitle;
  dynamic discount;

  Data.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
    type = json['type'];
    whatsapptext = json['whatsapptext'];
    keyword = json['keyword'];
    bannerTitle = json['banner_title'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['banner_image'] = bannerImage;
    data['type'] = type;
    data['whatsapptext'] = whatsapptext;
    data['keyword'] = keyword;
    data['banner_title'] = bannerTitle;
    data['discount'] = discount;
    return data;
  }
}
