class CatChackBoxList {
  String? status;
  List<DataCheck>? data;

  CatChackBoxList({this.status, this.data});

  CatChackBoxList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCheck>[];
      json['data'].forEach((v) {
        data!.add(DataCheck.fromJson(v));
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

class DataCheck {
  String? categoryId;
  String? categoryName;
  String? isRestricted;
  String? childCount;
  String? isRestrictedWithChild;
  bool? isSelected;

  DataCheck(
      {this.categoryId,
        this.categoryName,
        this.isRestricted,
        this.childCount,
        this.isRestrictedWithChild,
        this.isSelected,});

  DataCheck.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    isRestricted = json['is_restricted'];
    childCount = json['child_count'];
    isRestrictedWithChild = json['is_restricted_with_child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['is_restricted'] = isRestricted;
    data['child_count'] = childCount;
    data['is_restricted_with_child'] = isRestrictedWithChild;
    return data;
  }
}
