class CategoryCat1stModel {
  String? status;
  List<Banner1>? banner1;
  List<Banner2>? banner2;
  List<SubCategories>? subCategories;
  List<SpecialDiscountZone>? specialDiscountZone;
  List<dynamic>? offerAdda;
  String? subCatIds;
  List<String>? subCatName;

  CategoryCat1stModel({
    this.status,
    this.banner1,
    this.banner2,
    this.subCategories,
    this.specialDiscountZone,
    this.offerAdda,
    this.subCatIds,
    this.subCatName,
  });

  factory CategoryCat1stModel.fromJson(Map<String, dynamic> json) {
    return CategoryCat1stModel(
      status: json['status'],
      banner1: (json['banner1'] as List<dynamic>?)
          ?.map((e) => Banner1.fromJson(e as Map<String, dynamic>))
          .toList(),
      banner2: (json['banner2'] as List<dynamic>?)
          ?.map((e) => Banner2.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => SubCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialDiscountZone: (json['special_discount_zone'] as List<dynamic>?)
          ?.map((e) => SpecialDiscountZone.fromJson(e as Map<String, dynamic>))
          .toList(),
      offerAdda: json['offer_adda'] as List<dynamic>?,
      subCatIds: json['sub_cat_ids'],
      subCatName: (json['sub_cat_name'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['banner1'] = banner1?.map((e) => e.toJson()).toList();
    data['banner2'] = banner2?.map((e) => e.toJson()).toList();
    data['sub_categories'] = subCategories?.map((e) => e.toJson()).toList();
    data['special_discount_zone'] =
        specialDiscountZone?.map((e) => e.toJson()).toList();
    data['offer_adda'] = offerAdda;
    data['sub_cat_ids'] = subCatIds;
    data['sub_cat_name'] = subCatName;
    return data;
  }
}

class Banner1 {
  Banner1({
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
    String? discount;

  Banner1.fromJson(Map<String, dynamic> json){
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

class Banner2 {
  Banner2({
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
  String? discount;

  Banner2.fromJson(Map<String, dynamic> json){
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

class SubCategories {
  String? name;
  String? keyword;
  String? img;
  List<String>? catIdList;
  FilterItem? filterItem; // Assuming FilterItem is a model

  SubCategories({
    this.name,
    this.keyword,
    this.img,
    this.catIdList,
    this.filterItem,
  });

  SubCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    keyword = json['keyword'];
    img = json['img'];
    catIdList = (json['cat_id'] as String?)?.split(',') ?? [];
    // Handle filter_item as Map<String, dynamic> or List<dynamic> depending on your JSON structure
    if (json['filter_item'] is Map<String, dynamic>) {
      filterItem = FilterItem.fromJson(json['filter_item'] as Map<String, dynamic>);
    } else {
      // Handle cases where filter_item is an empty array or not present
      filterItem = null; // or handle as needed
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'keyword': keyword,
      'img': img,
      'cat_id': catIdList?.join(','),
      // Serialize filterItem if needed
      'filter_item': filterItem?.toJson(),
    };
    return data;
  }
}

class FilterItem {
  List<String>? suitableFor;

  FilterItem({this.suitableFor});

  FilterItem.fromJson(Map<String, dynamic> json) {
    // Check if 'Suitable for' is present and if it's an array
    if (json.containsKey('Suitable for') && json['Suitable for'] is List) {
      suitableFor = List<String>.from(json['Suitable for']);
    } else {
      suitableFor = []; // Default to empty list if not present or not an array
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (suitableFor != null) {
      data['Suitable for'] = suitableFor;
    }
    return data;
  }
}

class SpecialDiscountZone {
  String? name;
  int? minPrice;
  int? maxPrice;
  String? image;
  List<String>? suitableFor;

  SpecialDiscountZone({
    this.name,
    this.minPrice,
    this.maxPrice,
    this.image,
    this.suitableFor,
  });

  SpecialDiscountZone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    image = json['image'];
    suitableFor = List<String>.from(json['Suitable for'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'min_price': minPrice,
      'max_price': maxPrice,
      'image': image,
      'Suitable for': suitableFor,
    };
    return data;
  }
}

