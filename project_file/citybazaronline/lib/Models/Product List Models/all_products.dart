class AllProducts {
  List<String>? breadcrumb;
  String? status;
  int? filterCount;
  String? randamId;
  int? countProducts;
  int? pageNo;
  int? totalPages;
  int? offset;
  int? limit;
  List<Product>? productList;

  AllProducts({
    this.breadcrumb,
    this.status,
    this.filterCount,
    this.randamId,
    this.countProducts,
    this.pageNo,
    this.totalPages,
    this.offset,
    this.limit,
    this.productList,
  });

  factory AllProducts.fromJson(Map<String, dynamic> json) {
    return AllProducts(
      breadcrumb: List<String>.from(json['breadcrumb']),
      status: json['status'],
      filterCount: json['filter_count'],
      randamId: json['randam_id'],
      countProducts: json['count_products'],
      pageNo: json['page_no'],
      totalPages: json['total_pages'],
      offset: json['offset'],
      limit: json['limit'],
      productList: List<Product>.from(json['product_list'].map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  String? productSlug;
  int? discount;
  int? imgGroupId;
  String? cashbackText;
  num? price; // Using num to handle both int and double
  String? productId;
  String? imageFile;
  String? productImgUrl;
  String? cashbackTag;
  String? distanceKm;
  num? showPrice; // Using num to handle both int and double
  num? offerPrice; // Using num to handle both int and double
  String? shopId;
  DateTime? createdDate;
  int? productCategory;
  String? shopName;
  String? productName;
  String? brand;
  String? storeSlug;
  String? cloneId;
  String? contactNo;
  String? whatsapptext;
  String? wantToBuy;

  Product({
     this.productSlug,
     this.discount,
     this.imgGroupId,
     this.cashbackText,
     this.price,
     this.productId,
     this.imageFile,
     this.productImgUrl,
     this.cashbackTag,
     this.distanceKm,
     this.showPrice,
     this.offerPrice,
     this.shopId,
     this.createdDate,
     this.productCategory,
     this.shopName,
     this.productName,
     this.brand,
     this.storeSlug,
     this.cloneId,
     this.contactNo,
     this.whatsapptext,
     this.wantToBuy,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productSlug: json['product_slug'],
      discount: json['discount'],
      imgGroupId: json['img_group_id'],
      cashbackText: json['cashback_text'],
      price: json['price'],
      productId: json['product_id'],
      imageFile: json['image_file'],
      productImgUrl: json['product_img_url'],
      cashbackTag: json['cashback_tag'],
      distanceKm: json['distance_km'],
      showPrice: json['show_price'],
      offerPrice: json['offer_price'],
      shopId: json['shop_id'],
      createdDate: DateTime.parse(json['created_date']),
      productCategory: json['product_category'],
      shopName: json['shop_name'],
      productName: json['product_name'],
      brand: json['brand'],
      storeSlug: json['store_slug'],
      cloneId: json['clone_id'],
      contactNo: json['contact_no'],
      whatsapptext: json['whatsapptext'],
      wantToBuy: json['want_to_buy'],
    );
  }
}


/*---------------------Product list filter-----------------*/

class ProductListFilter {
  String? status;
  int? minPrice;
  int? maxPrice;
  List<Categories>? categories;
  List<Attributes>? attributes;

  ProductListFilter(
      {this.status,
        this.minPrice,
        this.maxPrice,
        this.categories,
        this.attributes});

  ProductListFilter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
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

class Categories {
  String? categoryId;
  String? categoryName;
  bool? isSelected;

  Categories({this.categoryId, this.categoryName});

  Categories.fromJson(Map<String, dynamic> json) {
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

class Attributes {
  String? attrName;
  List<String>? attrValues;
  List<bool?>? isSelectedValues;

  Attributes({
    this.attrName,
    this.attrValues,
    List<bool?>? isSelectedValues, // Update constructor
  }) : isSelectedValues = isSelectedValues ?? List<bool?>.generate(attrValues?.length ?? 0, (_) => false);

  Attributes.fromJson(Map<String, dynamic> json) {
    attrName = json['attr_name'];
    attrValues = json['attr_values'] == null ? [] : List<String>.from(json['attr_values']);
    isSelectedValues = List<bool?>.generate(attrValues?.length ?? 0, (_) => false);
  }

  // factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
  //   attrName: json["attr_name"],
  //   attrValues: json["attr_values"] == null ? []
  //       : List<String>.from(json["attr_values"]!.map((x) => x)),
  // );

  Map<String, dynamic> toJson() => {
    "attr_name": attrName,
    "attr_values": attrValues == null ? [] : List<dynamic>.from(attrValues!.map((x) => x)),
  };

  // Map<String, dynamic> toJson() => {
  //   "attr_name": attrName,
  //   "attr_values": attrValues == null ? []
  //       : List<dynamic>.from(attrValues!.map((x) => x)),
  // };
}


/////////////////////////////////////////////////////////
