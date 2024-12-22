class SellerProductFilter {
  String? status;
  int? minPrice;
  int? maxPrice;
  List<Category>? categories;
  List<Attribute>? attributes;

  SellerProductFilter(
      {this.status,
        this.minPrice,
        this.maxPrice,
        this.categories,
        this.attributes});

  SellerProductFilter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attribute>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Attribute {
  String? attrName;
  List<String>? attrValues;
  List<bool?>? isSelectedValues;

  Attribute({
    this.attrName,
    this.attrValues,
    List<bool?>? isSelectedValues,
  }) : isSelectedValues = isSelectedValues ?? [];

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      attrName: json["attr_name"] != null ? json["attr_name"] as String : "",
      attrValues: json["attr_values"] != null
          ? List<String>.from((json["attr_values"] as List<dynamic>)
          .map((v) => v.toString()))
          : [],
    )
      ..isSelectedValues = json["attr_values"] != null
          ? List<bool?>.generate(
        (json["attr_values"] as List<dynamic>).length,
            (_) => false,
      )
          : [];
  }

  Map<String, dynamic> toJson() => {
    "attr_name": attrName,
    "attr_values": attrValues == null ? [] : List<dynamic>.from(attrValues!.map((x) => x)),
  };
}



// class Attribute {
//   String? attrName;
//   List<String>? attrValues;
//   List<bool?>? isSelectedValues;
//
//   Attribute({
//     this.attrName,
//     this.attrValues,
//     List<bool?>? isSelectedValues, // Update constructor
//   }) : isSelectedValues = isSelectedValues ?? List<bool?>.generate(attrValues?.length ?? 0, (_) => false);
//
//   factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//     attrName: json["attr_name"],
//     attrValues: json["attr_values"] == null ? []
//         : List<String>.from(json["attr_values"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "attr_name": attrName,
//     "attr_values": attrValues == null ? []
//         : List<dynamic>.from(attrValues!.map((x) => x)),
//   };
// }

class Category {
  String? categoryId;
  String? categoryName;
  bool? isSelected;

  Category({this.categoryId, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
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