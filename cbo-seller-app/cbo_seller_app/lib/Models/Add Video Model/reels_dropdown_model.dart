class ReelsDropdownModel {
  String? status;
  ReelsDropdownData? data;

  ReelsDropdownModel({this.status, this.data});

  ReelsDropdownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ReelsDropdownData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReelsDropdownData {
  List<ChildCat>? childCat;

  ReelsDropdownData({this.childCat});

  ReelsDropdownData.fromJson(Map<String, dynamic> json) {
    if (json['child_cat'] != null) {
      childCat = <ChildCat>[];
      json['child_cat'].forEach((v) {
        childCat!.add(ChildCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (childCat != null) {
      data['child_cat'] = childCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCat {
  String? categoryId;
  String? cat;
  String? pcat1;
  String? pcat2;
  String? pcat3;

  ChildCat({this.categoryId, this.cat, this.pcat1, this.pcat2, this.pcat3});

  ChildCat.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    cat = json['cat'];
    pcat1 = json['pcat1'];
    pcat2 = json['pcat2'];
    pcat3 = json['pcat3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['cat'] = cat;
    data['pcat1'] = pcat1;
    data['pcat2'] = pcat2;
    data['pcat3'] = pcat3;
    return data;
  }
}
