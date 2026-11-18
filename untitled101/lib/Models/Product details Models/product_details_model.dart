class ProductDetailsField {
  List<String>? breadcrumb;
  ProductDetails? productDetails;
  List<AttributeList>? attributeList;
  List<AllProductVariant>? allProductVariant;
  List<SimilarProduct>? similarProduct;
  dynamic contactNo;
  dynamic shareLink;
  dynamic whatsapptext;
  dynamic liked;
  dynamic wishlisted;
  dynamic wantToBuy;
  dynamic is_cart;
  dynamic status;
  dynamic booked;

  ProductDetailsField({
    this.breadcrumb,
    this.productDetails,
    this.attributeList,
    this.allProductVariant,
    this.similarProduct,
    this.contactNo,
    this.shareLink,
    this.whatsapptext,
    this.liked,
    this.wishlisted,
    this.wantToBuy,
    this.is_cart,
    this.status,
    this.booked,
  });

  ProductDetailsField.fromJson(Map<String, dynamic> json)
      : breadcrumb = (json['breadcrumb'] as List?)?.map((dynamic e) => e as String).toList(),
        productDetails = json['product_details'] != null
            ? ProductDetails.fromJson(json['product_details'] as Map<String, dynamic>)
            : null,
        attributeList = (json['attribute_list'] as List?)?.map((dynamic e) => AttributeList.fromJson(e as Map<String, dynamic>)).toList(),
        allProductVariant = (json['all_product_variant'] as List?)?.map((dynamic e) => AllProductVariant.fromJson(e as Map<String, dynamic>)).toList(),
        similarProduct = (json['similar_product'] as List?)?.map((dynamic e) => SimilarProduct.fromJson(e as Map<String, dynamic>)).toList(),
        contactNo = json['contact_no'],
        shareLink = json['share_link'],
        whatsapptext = json['whatsapptext'],
        liked = json['liked'],
        wishlisted = json['wishlisted'],
        wantToBuy = json['want_to_buy'],
        is_cart = json['is_cart'],
        status = json['status'],
        booked = json['booked'];
}

class ProductDetails {
  List<Details>? details;
  VariantList? variantList;
  List<dynamic>? sizeAr;
  List<ColorAr>? colorAr;
  List<dynamic>? colourAr;
  SellerName? sellerName;

  ProductDetails({
    this.details,
    this.variantList,
    this.sizeAr,
    this.colorAr,
    this.colourAr,
    this.sellerName,
  });

  ProductDetails.fromJson(Map<String, dynamic> json)
      : details = (json['details'] as List?)?.map((dynamic e) => Details.fromJson(e as Map<String, dynamic>)).toList(),
        // variantList = json['variant_list'] != null
        //     ? VariantList.fromJson(json['variant_list'] as Map<String, dynamic>)
        //     : null,
        variantList = json['variant_list'] != null
            ? json['variant_list'] is List
            ? VariantList.fromJson(<String, dynamic>{'color': json['variant_list'],'size': json['variant_list']})
            : VariantList.fromJson(json['variant_list'] as Map<String, dynamic>)
            : null,
        sizeAr = json['size_ar'] as List<dynamic>?,
        colorAr = (json['color_ar'] as List?)?.map((dynamic e) => ColorAr.fromJson(e as Map<String, dynamic>)).toList(),
        colourAr = json['colour_ar'] as List<dynamic>?,
        sellerName = json['seller_name'] != null ? SellerName.fromJson(json['seller_name'] as Map<String, dynamic>) : null;
}

// class ProductDetails {
//    List<Details>? details;
//    VariantList? variantList;
//    List<dynamic>? sizeAr;
//    List<ColorAr>? colorAr;
//    List<dynamic>? colourAr;
//    SellerName? sellerName;
//
//   ProductDetails({
//     this.details,
//     this.variantList,
//     this.sizeAr,
//     this.colorAr,
//     this.colourAr,
//     this.sellerName,
//   });
//
//   // ProductDetails.fromJson(Map<String, dynamic> json)
//   //     : details = (json['details'] as List?)?.map((dynamic e) => Details.fromJson(e as Map<String,dynamic>)).toList(),
//   //       variantList = (json['variant_list'] as Map<String,dynamic>?) != null ? VariantList.fromJson(json['variant_list'] as Map<String,dynamic>) : null,
//   //       sizeAr = json['size_ar'] as List?,
//   //       colorAr = (json['color_ar'] as List?)?.map((dynamic e) => ColorAr.fromJson(e as Map<String,dynamic>)).toList(),
//   //       colourAr = json['colour_ar'] as List?,
//   //       sellerName = (json['seller_name'] as Map<String,dynamic>?) != null ? SellerName.fromJson(json['seller_name'] as Map<String,dynamic>) : null;
//
//    ProductDetails.fromJson(Map<String, dynamic> json)
//        : details = (json['details'] as List?)?.map((dynamic e) => Details.fromJson(e as Map<String,dynamic>)).toList(),
//      //    variantList = json['variant_list'] != null ? VariantList.fromJson(json['variant_list'] as Map<String,dynamic>) : null,
//          variantList = json['variant_list'] != null
//              ? json['variant_list'] is List
//              ? VariantList.fromJson(<String, dynamic>{'color': json['variant_list'],'size': json['variant_list']})
//              : VariantList.fromJson(json['variant_list'] as Map<String, dynamic>)
//              : null,
//          sizeAr = json['size_ar'] as List<dynamic>?,
//          colorAr = (json['color_ar'] as List?)?.map((dynamic e) => ColorAr.fromJson(e as Map<String,dynamic>)).toList(),
//          colourAr = json['colour_ar'] as List<dynamic>?,
//          sellerName = json['seller_name'] != null ? SellerName.fromJson(json['seller_name'] as Map<String,dynamic>) : null;
//
//
//    Map<String, dynamic> toJson() => {
//     'details' : details?.map((e) => e.toJson()).toList(),
//     'variant_list' : variantList?.toJson(),
//     'size_ar' : sizeAr,
//     'color_ar' : colorAr?.map((e) => e.toJson()).toList(),
//     'colour_ar' : colourAr,
//     'seller_name' : sellerName?.toJson()
//   };
// }

class Details {
   String? productId;
   String? variantGroupId;
   String? productReferenceId;
   String? imgGroupId;
   String? sku;
   String? is_cart;
   String? productName;
   String? productSlug;
   String? model;
   String? price;
   String? offerPrice;
   String? offerStartDate;
   String? offerEndDate;
   String? stockQuantity;
   String? isAvailable;
   String? productCategory;
   String? isActive;
   String? isApproved;
   String? isDeleted;
   String? rejectionDate;
   String? rejectionRemarks;
   String? createdDate;
   String? createdBy;
   String? modifiedDate;
   String? modifiedBy;
   String? productDetailId;
   String? brand;
   String? warranty;
   String? description;
   String? variantCount;
   String? shortDescription;
   String? otherFeature;
   String? sizeOfProduct;
   String? sellerId;
   String? storeName;
   String? storeSlug;
   String? contactNo;
   String? imageFile;
   String? productImgUrl;
   String? avgRating;
   String? catName;
   bool? cashbackTag;
   String? cashbackText;

  Details({
    this.productId,
    this.variantGroupId,
    this.productReferenceId,
    this.imgGroupId,
    this.sku,
    this.is_cart,
    this.productName,
    this.productSlug,
    this.model,
    this.price,
    this.offerPrice,
    this.offerStartDate,
    this.offerEndDate,
    this.stockQuantity,
    this.isAvailable,
    this.productCategory,
    this.isActive,
    this.isApproved,
    this.isDeleted,
    this.rejectionDate,
    this.rejectionRemarks,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.productDetailId,
    this.brand,
    this.warranty,
    this.description,
    this.variantCount,
    this.shortDescription,
    this.otherFeature,
    this.sizeOfProduct,
    this.sellerId,
    this.storeName,
    this.storeSlug,
    this.contactNo,
    this.imageFile,
    this.productImgUrl,
    this.avgRating,
    this.catName,
    this.cashbackTag,
    this.cashbackText,
  });

  Details.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        variantGroupId = json['variant_group_id'] as String?,
        productReferenceId = json['product_reference_id'] as String?,
        imgGroupId = json['img_group_id'] as String?,
        sku = json['sku'] as String?,
        is_cart = json['is_cart'] as String?,
        productName = json['product_name'] as String?,
        productSlug = json['product_slug'] as String?,
        model = json['model'] as String?,
        price = json['price'] as String?,
        offerPrice = json['offer_price'] as String?,
        offerStartDate = json['offer_start_date']as String?,
        offerEndDate = json['offer_end_date']as String?,
        stockQuantity = json['stock_quantity'] as String?,
        isAvailable = json['is_available'] as String?,
        productCategory = json['product_category'] as String?,
        isActive = json['is_active'] as String?,
        isApproved = json['is_approved'] as String?,
        isDeleted = json['is_deleted'] as String?,
        rejectionDate = json['rejection_date']as String?,
        rejectionRemarks = json['rejection_remarks'],
        createdDate = json['created_date'] as String?,
        createdBy = json['created_by'] as String?,
        modifiedDate = json['modified_date'] as String?,
        modifiedBy = json['modified_by'] as String?,
        productDetailId = json['product_detail_id'] as String?,
        brand = json['brand'] as String?,
        warranty = json['warranty'] as String?,
        description = json['description'] as String?,
        variantCount = json['variant_count'] as String?,
        shortDescription = json['short_description'] as String?,
        otherFeature = json['other_feature'] as String?,
        sizeOfProduct = json['size_of_product']as String?,
        sellerId = json['seller_id'] as String?,
        storeName = json['store_name'] as String?,
        storeSlug = json['store_slug'] as String?,
        contactNo = json['contact_no'] as String?,
        imageFile = json['image_file'] as String?,
        productImgUrl = json['product_img_url'] as String?,
        avgRating = json['avg_rating']as String?,
        catName = json['cat_name'] as String?,
        cashbackTag = json['cashback_tag'] as bool?,
        cashbackText = json['cashback_text'] as String?;

  Map<String, dynamic> toJson() => {
    'product_id' : productId,
    'variant_group_id' : variantGroupId,
    'product_reference_id' : productReferenceId,
    'img_group_id' : imgGroupId,
    'sku' : sku,
    'is_cart' : is_cart,
    'product_name' : productName,
    'product_slug' : productSlug,
    'model' : model,
    'price' : price,
    'offer_price' : offerPrice,
    'offer_start_date' : offerStartDate,
    'offer_end_date' : offerEndDate,
    'stock_quantity' : stockQuantity,
    'is_available' : isAvailable,
    'product_category' : productCategory,
    'is_active' : isActive,
    'is_approved' : isApproved,
    'is_deleted' : isDeleted,
    'rejection_date' : rejectionDate,
    'rejection_remarks' : rejectionRemarks,
    'created_date' : createdDate,
    'created_by' : createdBy,
    'modified_date' : modifiedDate,
    'modified_by' : modifiedBy,
    'product_detail_id' : productDetailId,
    'brand' : brand,
    'warranty' : warranty,
    'description' : description,
    'variant_count' : variantCount,
    'short_description' : shortDescription,
    'other_feature' : otherFeature,
    'size_of_product' : sizeOfProduct,
    'seller_id' : sellerId,
    'store_name' : storeName,
    'store_slug' : storeSlug,
    'contact_no' : contactNo,
    'image_file' : imageFile,
    'product_img_url' : productImgUrl,
    'avg_rating' : avgRating,
    'cat_name' : catName,
    'cashback_tag' : cashbackTag,
    'cashback_text' : cashbackText
  };
}

class VariantList {
  VariantList({
    List<Color>? color,
    List<SizeData>? size,
  })  : color = color ?? [],
        size = size ?? [];

  List<Color> color;
  List<SizeData> size;

  VariantList.fromJson(Map<String, dynamic> json)
      : color = ((json['color'] as List?)?.map((e) => Color.fromJson(e as Map<String, dynamic>)).toList() ?? []),
        size = ((json['size'] as List?)?.map((e) => SizeData.fromJson(e as Map<String, dynamic>)).toList() ?? []);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['color'] = color.map((e) => e.toJson()).toList();
    _data['size'] = size.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Color {
  Color({
    String? attributeValue,
    String? imgGroupId,
    String? productId,
    String? productSlug,
    String? colorCode,
    String? imageFile,
  })  : attributeValue = attributeValue ?? '',
        imgGroupId = imgGroupId ?? '',
        productId = productId ?? '',
        productSlug = productSlug ?? '',
        colorCode = colorCode ?? '',
        imageFile = imageFile ?? '';

  String attributeValue;
  String imgGroupId;
  String productId;
  String productSlug;
  String colorCode;
  String imageFile;

  Color.fromJson(Map<String, dynamic> json)
      : attributeValue = json['attribute_value'] as String? ?? '',
       productId = json['product_id'] as String? ?? '',
        imgGroupId = json['img_group_id'] as String? ?? '',
        productSlug = json['product_slug'] as String? ?? '',
        colorCode = json['color_code'] as String? ?? '',
        imageFile = json['image_file'] as String? ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attribute_value'] = attributeValue;
    data['img_group_id'] = imgGroupId;
    data['product_id'] = productId;
    data['product_slug'] = productSlug;
    data['color_code'] = colorCode;
    data['image_file'] = imageFile;
    return data;
  }
}

class SizeData {
  SizeData({
    String? attributeValue,
    String? productId,
    String? productSlug,
    String? imgGroupId,
    String? imageFile,
  })  : attributeValue = attributeValue ?? '',
        productId = productId ?? '',
        productSlug = productSlug ?? '',
        imgGroupId = imgGroupId ?? '',
        imageFile = imageFile ?? '';

  String attributeValue;
  String productId;
  String productSlug;
  String imgGroupId;
  String imageFile;

  SizeData.fromJson(Map<String, dynamic> json)
      : attributeValue = json['attribute_value'] as String? ?? '',
        productId = json['product_id'] as String? ?? '',
        productSlug = json['product_slug'] as String? ?? '',
        imgGroupId = json['img_group_id'] as String? ?? '',
        imageFile = json['image_file'] as String? ?? '';

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['attribute_value'] = attributeValue;
    _data['product_id'] = productId;
    _data['product_slug'] = productSlug;
    _data['img_group_id'] = imgGroupId;
    _data['image_file'] = imageFile;
    return _data;
  }
}

class ColorAr {
   String? attributeValue;
   String? imgGroupId;
   String? productSlug;
   String? colorCode;
   String? imageFile;

  ColorAr({
    this.attributeValue,
    this.imgGroupId,
    this.productSlug,
    this.colorCode,
    this.imageFile,
  });

  ColorAr.fromJson(Map<String, dynamic> json)
      : attributeValue = json['attribute_value'] as String?,
        imgGroupId = json['img_group_id'] as String?,
        productSlug = json['product_slug'] as String?,
        colorCode = json['color_code'] as String?,
        imageFile = json['image_file'] as String?;

  Map<String, dynamic> toJson() => {
    'attribute_value' : attributeValue,
    'img_group_id' : imgGroupId,
    'product_slug' : productSlug,
    'color_code' : colorCode,
    'image_file' : imageFile
  };
}

class SellerName {
   String? sellerName;
   String? sellerUrl;
   String? sellerContactNo;

  SellerName({
    this.sellerName,
    this.sellerUrl,
    this.sellerContactNo,
  });

  SellerName.fromJson(Map<String, dynamic> json)
      : sellerName = json['seller_name'] as String?,
        sellerUrl = json['seller_url'] as String?,
        sellerContactNo = json['seller_contact_no'] as String?;

  Map<String, dynamic> toJson() => {
    'seller_name' : sellerName,
    'seller_url' : sellerUrl,
    'seller_contact_no' : sellerContactNo
  };
}

class AttributeList {
   String? attrName;
   String? attrValue;

  AttributeList({
    this.attrName,
    this.attrValue,
  });

  AttributeList.fromJson(Map<String, dynamic> json)
      : attrName = json['attr_name'] as String?,
        attrValue = json['attr_value'] as String?;

  Map<String, dynamic> toJson() => {
    'attr_name' : attrName,
    'attr_value' : attrValue
  };
}

class AllProductVariant {
   String? productId;
   String? variantGroupId;
   String? imgGroupId;
   String? productReferenceId;
   String? colorValue;
   dynamic sizeValue;
   String? sku;
   String? productSlug;
   String? brand;
   String? model;
   String? price;
   String? offerPrice;
   dynamic offerStartDate;
   dynamic offerEndDate;
   String? isAvailable;

  AllProductVariant({
    this.productId,
    this.variantGroupId,
    this.imgGroupId,
    this.productReferenceId,
    this.colorValue,
    this.sizeValue,
    this.sku,
    this.productSlug,
    this.brand,
    this.model,
    this.price,
    this.offerPrice,
    this.offerStartDate,
    this.offerEndDate,
    this.isAvailable,
  });

  AllProductVariant.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        variantGroupId = json['variant_group_id'] as String?,
        imgGroupId = json['img_group_id'] as String?,
        productReferenceId = json['product_reference_id'] as String?,
        colorValue = json['color_value'] as String?,
        sizeValue = json['size_value'],
        sku = json['sku'] as String?,
        productSlug = json['product_slug'] as String?,
        brand = json['brand'] as String?,
        model = json['model'] as String?,
        price = json['price'] as String?,
        offerPrice = json['offer_price'] as String?,
        offerStartDate = json['offer_start_date'],
        offerEndDate = json['offer_end_date'],
        isAvailable = json['is_available'] as String?;

  Map<String, dynamic> toJson() => {
    'product_id' : productId,
    'variant_group_id' : variantGroupId,
    'img_group_id' : imgGroupId,
    'product_reference_id' : productReferenceId,
    'color_value' : colorValue,
    'size_value' : sizeValue,
    'sku' : sku,
    'product_slug' : productSlug,
    'brand' : brand,
    'model' : model,
    'price' : price,
    'offer_price' : offerPrice,
    'offer_start_date' : offerStartDate,
    'offer_end_date' : offerEndDate,
    'is_available' : isAvailable
  };
}

class SimilarProduct {
   String? productId;
   String? productName;
   String? imageFile;
   String? productSlug;
   String? price;
   String? offerPrice;
   String? storeSlug;
   String? distanceKm;
   String? shareLink;
   String? whatsapptext;
   String? wantToBuy;

  SimilarProduct({
    this.productId,
    this.productName,
    this.imageFile,
    this.productSlug,
    this.price,
    this.offerPrice,
    this.storeSlug,
    this.distanceKm,
    this.shareLink,
    this.whatsapptext,
    this.wantToBuy,
  });

  SimilarProduct.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'] as String?,
        productName = json['product_name'] as String?,
        imageFile = json['image_file'] as String?,
        productSlug = json['product_slug'] as String?,
        price = json['price'] as String?,
        offerPrice = json['offer_price'] as String?,
        storeSlug = json['store_slug'] as String?,
        distanceKm = json['distance_km'] as String?,
        shareLink = json['share_link'] as String?,
        whatsapptext = json['whatsapptext'] as String?,
        wantToBuy = json['want_to_buy'] as String?;

  Map<String, dynamic> toJson() => {
    'product_id' : productId,
    'product_name' : productName,
    'image_file' : imageFile,
    'product_slug' : productSlug,
    'price' : price,
    'offer_price' : offerPrice,
    'store_slug' : storeSlug,
    'distance_km' : distanceKm,
    'share_link' : shareLink,
    'whatsapptext' : whatsapptext,
    'want_to_buy' : wantToBuy
  };
}
















//       : details = (json['details'] as List?)?.map((dynamic e) => Details.fromJson(e as Map<String,dynamic>)).toList(),
//          variantList = (json['variant_list'] != null && (json['variant_list'] as List).isNotEmpty)
//              ? VariantList.fromJson(json['variant_list'] as Map<String, dynamic>)
//              : null,
//          sizeAr = (json['size_ar'] != null && (json['size_ar'] as List).isNotEmpty)
//              ? (json['size_ar'] as List).map((dynamic e) => e as String).toList()
//              : null,
//
//          colorAr = (json['color_ar'] != null && (json['color_ar'] as List).isNotEmpty)
//              ? (json['color_ar'] as List).map((dynamic e) => ColorAr.fromJson(e as Map<String, dynamic>)).toList()
//              : null,
//
//          colourAr = (json['colour_ar'] != null && (json['colour_ar'] as List).isNotEmpty)
//              ? (json['colour_ar'] as List).map((dynamic e) => e as String).toList()
//              : null,