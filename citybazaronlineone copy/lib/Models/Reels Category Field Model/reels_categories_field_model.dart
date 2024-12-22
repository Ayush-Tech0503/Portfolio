// class ReelsCategoriesList {
//   String? status;
//   Data? data;
//
//   ReelsCategoriesList({this.status, this.data});
//
//   ReelsCategoriesList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<ChildCatData>? childCat;
//
//   Data({this.childCat});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['child_cat'] != null) {
//       childCat = <ChildCatData>[];
//       json['child_cat'].forEach((v) {
//         childCat!.add(ChildCatData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (childCat != null) {
//       data['child_cat'] = childCat!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ChildCatData {
//   int? categoryId;
//   String? cat;
//   String? pcat1;
//   String? pcat2;
//   String? pcat3;
//   bool? isSelected;
//
//   ChildCatData({this.categoryId, this.cat, this.pcat1, this.pcat2, this.pcat3,this.isSelected});
//
//   ChildCatData.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     cat = json['cat'];
//     pcat1 = json['pcat1'];
//     pcat2 = json['pcat2'];
//     pcat3 = json['pcat3'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['category_id'] = categoryId;
//     data['cat'] = cat;
//     data['pcat1'] = pcat1;
//     data['pcat2'] = pcat2;
//     data['pcat3'] = pcat3;
//     return data;
//   }
// }

//------------------------------------------------------------------------------


// class ReelsCategoriesList {
//   String? status;
//   Data? data;
//
//   ReelsCategoriesList({this.status, this.data});
//
//   ReelsCategoriesList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<ChildCatData>? childCat;
//
//   Data({this.childCat});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['child_cat'] != null) {
//       childCat = <ChildCatData>[];
//       json['child_cat'].forEach((v) {
//         childCat!.add(ChildCatData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (childCat != null) {
//       data['child_cat'] = childCat!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ChildCatData {
//   String? categoryId;
//   String? cat;
//   String? pcat1;
//   String? pcat2;
//   String? pcat3;
//   bool? isSelected;
//
//   ChildCatData({this.categoryId, this.cat, this.pcat1, this.pcat2, this.pcat3, this.isSelected});
//
//   ChildCatData.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     cat = json['cat'];
//     pcat1 = json['pcat1'];
//     pcat2 = json['pcat2'];
//     pcat3 = json['pcat3'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['category_id'] = categoryId;
//     data['cat'] = cat;
//     data['pcat1'] = pcat1;
//     data['pcat2'] = pcat2;
//     data['pcat3'] = pcat3;
//     return data;
//   }
// }

//------------------------------------------------------------------------------
class ReelsCategoriesList {
  String? status;
  List<Data>? data;

  ReelsCategoriesList({this.status, this.data});

  ReelsCategoriesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? categoryId;
  String? categoryName;
  bool? isSelected;

  Data({this.categoryId, this.categoryName,  this.isSelected});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}
