// To parse this JSON data, do
//
//     final productDropDownListModel = productDropDownListModelFromJson(jsonString);

import 'dart:convert';

ProductDropDownListModel productDropDownListModelFromJson(String str) => ProductDropDownListModel.fromJson(json.decode(str));

String productDropDownListModelToJson(ProductDropDownListModel data) => json.encode(data.toJson());

class ProductDropDownListModel {
  String? status;
  ProductDropDownListData? data;

  ProductDropDownListModel({
    this.status,
    this.data,
  });

  factory ProductDropDownListModel.fromJson(Map<String, dynamic> json) => ProductDropDownListModel(
    status: json["status"],
    data: json["data"] == null ? null : ProductDropDownListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class ProductDropDownListData {
  CatTree? catTree;
  CatTree? mCategory;
  List<ChildCat>? childCat;
  ProductAccess? productAccess;
  List<CatItem>? catItems;

  ProductDropDownListData({
    this.catTree,
    this.mCategory,
    this.childCat,
    this.productAccess,
    this.catItems,
  });

  factory ProductDropDownListData.fromJson(Map<String, dynamic> json) => ProductDropDownListData(
    catTree: json["cat_tree"] == null ? null : CatTree.fromJson(json["cat_tree"]),
    mCategory: json["m_category"] == null ? null : CatTree.fromJson(json["m_category"]),
    childCat: json["child_cat"] == null ? [] : List<ChildCat>.from(json["child_cat"]!.map((x) => ChildCat.fromJson(x))),
    productAccess: json["product_access"] == null ? null : ProductAccess.fromJson(json["product_access"]),
    catItems: json["cat_items"] == null ? [] : List<CatItem>.from(json["cat_items"]!.map((x) => CatItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cat_tree": catTree?.toJson(),
    "m_category": mCategory?.toJson(),
    "child_cat": childCat == null ? [] : List<dynamic>.from(childCat!.map((x) => x.toJson())),
    "product_access": productAccess?.toJson(),
    "cat_items": catItems == null ? [] : List<dynamic>.from(catItems!.map((x) => x.toJson())),
  };
}

class CatItem {
  int? categoryId;
  String? categoryName;
  int? parentCategory;
  int? isRestricted;

  CatItem({
    this.categoryId,
    this.categoryName,
    this.parentCategory,
    this.isRestricted,
  });

  factory CatItem.fromJson(Map<String, dynamic> json) => CatItem(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    parentCategory: json["parent_category"],
    isRestricted: json["is_restricted"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "parent_category": parentCategory,
    "is_restricted": isRestricted,
  };
}

class CatTree {
  The79HomeAppliances0? the79HomeAppliances0;
  The58Electronics1? the58Electronics1;
  The357SportsFitness0? the357SportsFitness0;
  The98ComputersAccessories0? the98ComputersAccessories0;
  The89ToysBabyCare0? the89ToysBabyCare0;
  The701MusicalInstruments0? the701MusicalInstruments0;
  The608HouseFinishingMaterialTools0? the608HouseFinishingMaterialTools0;
  The370HomeKitchenAccessories0? the370HomeKitchenAccessories0;
  The835IndustrialScientificSupplies0? the835IndustrialScientificSupplies0;
  The786AutomotiveCareAccessories0? the786AutomotiveCareAccessories0;
  The103HealthBeautyPersonnelCare0? the103HealthBeautyPersonnelCare0;
  The298Furniture0? the298Furniture0;
  The1Clothing0? the1Clothing0;
  The522TravelProducts0? the522TravelProducts0;
  List<String>? the295HomeFurnishing0;
  The92FootwearAccessories0? the92FootwearAccessories0;
  The675HomeDecor0? the675HomeDecor0;
  The242FashionPersonalAccessories0? the242FashionPersonalAccessories0;
  The1289EyewearCare0? the1289EyewearCare0;
  The1554Vehicles0? the1554Vehicles0;
  List<String>? the825MobilePhone0;
  CatTree1213IndoorGames0? the1213IndoorGames0;

  CatTree({
    this.the79HomeAppliances0,
    this.the58Electronics1,
    this.the357SportsFitness0,
    this.the98ComputersAccessories0,
    this.the89ToysBabyCare0,
    this.the701MusicalInstruments0,
    this.the608HouseFinishingMaterialTools0,
    this.the370HomeKitchenAccessories0,
    this.the835IndustrialScientificSupplies0,
    this.the786AutomotiveCareAccessories0,
    this.the103HealthBeautyPersonnelCare0,
    this.the298Furniture0,
    this.the1Clothing0,
    this.the522TravelProducts0,
    this.the295HomeFurnishing0,
    this.the92FootwearAccessories0,
    this.the675HomeDecor0,
    this.the242FashionPersonalAccessories0,
    this.the1289EyewearCare0,
    this.the1554Vehicles0,
    this.the825MobilePhone0,
    this.the1213IndoorGames0,
  });

  factory CatTree.fromJson(Map<String, dynamic> json) => CatTree(
    the79HomeAppliances0: json["79=Home appliances=0"] == null ? null : The79HomeAppliances0.fromJson(json["79=Home appliances=0"]),
    the58Electronics1: json["58=Electronics=1"] == null ? null : The58Electronics1.fromJson(json["58=Electronics=1"]),
    the357SportsFitness0: json["357=Sports & Fitness=0"] == null ? null : The357SportsFitness0.fromJson(json["357=Sports & Fitness=0"]),
    the98ComputersAccessories0: json["98=Computers & Accessories=0"] == null ? null : The98ComputersAccessories0.fromJson(json["98=Computers & Accessories=0"]),
    the89ToysBabyCare0: json["89=Toys & Baby Care=0"] == null ? null : The89ToysBabyCare0.fromJson(json["89=Toys & Baby Care=0"]),
    the701MusicalInstruments0: json["701=Musical Instruments=0"] == null ? null : The701MusicalInstruments0.fromJson(json["701=Musical Instruments=0"]),
    the608HouseFinishingMaterialTools0: json["608=House finishing material & Tools=0"] == null ? null : The608HouseFinishingMaterialTools0.fromJson(json["608=House finishing material & Tools=0"]),
    the370HomeKitchenAccessories0: json["370=Home & Kitchen Accessories=0"] == null ? null : The370HomeKitchenAccessories0.fromJson(json["370=Home & Kitchen Accessories=0"]),
    the835IndustrialScientificSupplies0: json["835=Industrial & Scientific Supplies=0"] == null ? null : The835IndustrialScientificSupplies0.fromJson(json["835=Industrial & Scientific Supplies=0"]),
    the786AutomotiveCareAccessories0: json["786=Automotive Care & Accessories=0"] == null ? null : The786AutomotiveCareAccessories0.fromJson(json["786=Automotive Care & Accessories=0"]),
    the103HealthBeautyPersonnelCare0: json["103=Health, Beauty & Personnel care=0"] == null ? null : The103HealthBeautyPersonnelCare0.fromJson(json["103=Health, Beauty & Personnel care=0"]),
    the298Furniture0: json["298=Furniture=0"] == null ? null : The298Furniture0.fromJson(json["298=Furniture=0"]),
    the1Clothing0: json["1=Clothing=0"] == null ? null : The1Clothing0.fromJson(json["1=Clothing=0"]),
    the522TravelProducts0: json["522=Travel Products=0"] == null ? null : The522TravelProducts0.fromJson(json["522=Travel Products=0"]),
    the295HomeFurnishing0: json["295=Home Furnishing=0"] == null ? [] : List<String>.from(json["295=Home Furnishing=0"]!.map((x) => x)),
    the92FootwearAccessories0: json["92=Footwear & Accessories=0"] == null ? null : The92FootwearAccessories0.fromJson(json["92=Footwear & Accessories=0"]),
    the675HomeDecor0: json["675=Home Decor=0"] == null ? null : The675HomeDecor0.fromJson(json["675=Home Decor=0"]),
    the242FashionPersonalAccessories0: json["242=Fashion & Personal Accessories=0"] == null ? null : The242FashionPersonalAccessories0.fromJson(json["242=Fashion & Personal Accessories=0"]),
    the1289EyewearCare0: json["1289=Eyewear & Care=0"] == null ? null : The1289EyewearCare0.fromJson(json["1289=Eyewear & Care=0"]),
    the1554Vehicles0: json["1554=Vehicles=0"] == null ? null : The1554Vehicles0.fromJson(json["1554=Vehicles=0"]),
    the825MobilePhone0: json["825=Mobile Phone=0"] == null ? [] : List<String>.from(json["825=Mobile Phone=0"]!.map((x) => x)),
    the1213IndoorGames0: json["1213=Indoor Games=0"] == null ? null : CatTree1213IndoorGames0.fromJson(json["1213=Indoor Games=0"]),
  );

  Map<String, dynamic> toJson() => {
    "79=Home appliances=0": the79HomeAppliances0?.toJson(),
    "58=Electronics=1": the58Electronics1?.toJson(),
    "357=Sports & Fitness=0": the357SportsFitness0?.toJson(),
    "98=Computers & Accessories=0": the98ComputersAccessories0?.toJson(),
    "89=Toys & Baby Care=0": the89ToysBabyCare0?.toJson(),
    "701=Musical Instruments=0": the701MusicalInstruments0?.toJson(),
    "608=House finishing material & Tools=0": the608HouseFinishingMaterialTools0?.toJson(),
    "370=Home & Kitchen Accessories=0": the370HomeKitchenAccessories0?.toJson(),
    "835=Industrial & Scientific Supplies=0": the835IndustrialScientificSupplies0?.toJson(),
    "786=Automotive Care & Accessories=0": the786AutomotiveCareAccessories0?.toJson(),
    "103=Health, Beauty & Personnel care=0": the103HealthBeautyPersonnelCare0?.toJson(),
    "298=Furniture=0": the298Furniture0?.toJson(),
    "1=Clothing=0": the1Clothing0?.toJson(),
    "522=Travel Products=0": the522TravelProducts0?.toJson(),
    "295=Home Furnishing=0": the295HomeFurnishing0 == null ? [] : List<dynamic>.from(the295HomeFurnishing0!.map((x) => x)),
    "92=Footwear & Accessories=0": the92FootwearAccessories0?.toJson(),
    "675=Home Decor=0": the675HomeDecor0?.toJson(),
    "242=Fashion & Personal Accessories=0": the242FashionPersonalAccessories0?.toJson(),
    "1289=Eyewear & Care=0": the1289EyewearCare0?.toJson(),
    "1554=Vehicles=0": the1554Vehicles0?.toJson(),
    "825=Mobile Phone=0": the825MobilePhone0 == null ? [] : List<dynamic>.from(the825MobilePhone0!.map((x) => x)),
    "1213=Indoor Games=0": the1213IndoorGames0?.toJson(),
  };
}

class The103HealthBeautyPersonnelCare0 {
  List<String>? the117SkinCare0;
  List<String>? the114FaceCare0;
  List<String>? the107Appliances0;
  List<String>? the116BathSpa0;
  List<String>? the108Fragrances0;
  List<String>? the115EyeMakeup0;
  The169Nails0? the169Nails0;
  List<String>? the106HairCareStyling0;
  List<String>? the109MakeUp0;
  List<String>? the113LipCare0;
  List<String>? the1303HealthNutrition0;
  List<String>? the828HealthCareDevices0;
  List<String>? the112OralCare0;

  The103HealthBeautyPersonnelCare0({
    this.the117SkinCare0,
    this.the114FaceCare0,
    this.the107Appliances0,
    this.the116BathSpa0,
    this.the108Fragrances0,
    this.the115EyeMakeup0,
    this.the169Nails0,
    this.the106HairCareStyling0,
    this.the109MakeUp0,
    this.the113LipCare0,
    this.the1303HealthNutrition0,
    this.the828HealthCareDevices0,
    this.the112OralCare0,
  });

  factory The103HealthBeautyPersonnelCare0.fromJson(Map<String, dynamic> json) => The103HealthBeautyPersonnelCare0(
    the117SkinCare0: json["117=Skin Care=0"] == null ? [] : List<String>.from(json["117=Skin Care=0"]!.map((x) => x)),
    the114FaceCare0: json["114=Face Care=0"] == null ? [] : List<String>.from(json["114=Face Care=0"]!.map((x) => x)),
    the107Appliances0: json["107=Appliances=0"] == null ? [] : List<String>.from(json["107=Appliances=0"]!.map((x) => x)),
    the116BathSpa0: json["116=Bath & Spa=0"] == null ? [] : List<String>.from(json["116=Bath & Spa=0"]!.map((x) => x)),
    the108Fragrances0: json["108=Fragrances=0"] == null ? [] : List<String>.from(json["108=Fragrances=0"]!.map((x) => x)),
    the115EyeMakeup0: json["115=Eye Makeup=0"] == null ? [] : List<String>.from(json["115=Eye Makeup=0"]!.map((x) => x)),
    the169Nails0: json["169=Nails=0"] == null ? null : The169Nails0.fromJson(json["169=Nails=0"]),
    the106HairCareStyling0: json["106=Hair Care & Styling=0"] == null ? [] : List<String>.from(json["106=Hair Care & Styling=0"]!.map((x) => x)),
    the109MakeUp0: json["109=Make up=0"] == null ? [] : List<String>.from(json["109=Make up=0"]!.map((x) => x)),
    the113LipCare0: json["113=Lip Care=0"] == null ? [] : List<String>.from(json["113=Lip Care=0"]!.map((x) => x)),
    the1303HealthNutrition0: json["1303=Health & Nutrition=0"] == null ? [] : List<String>.from(json["1303=Health & Nutrition=0"]!.map((x) => x)),
    the828HealthCareDevices0: json["828=Health Care Devices=0"] == null ? [] : List<String>.from(json["828=Health Care Devices=0"]!.map((x) => x)),
    the112OralCare0: json["112=Oral Care=0"] == null ? [] : List<String>.from(json["112=Oral Care=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "117=Skin Care=0": the117SkinCare0 == null ? [] : List<dynamic>.from(the117SkinCare0!.map((x) => x)),
    "114=Face Care=0": the114FaceCare0 == null ? [] : List<dynamic>.from(the114FaceCare0!.map((x) => x)),
    "107=Appliances=0": the107Appliances0 == null ? [] : List<dynamic>.from(the107Appliances0!.map((x) => x)),
    "116=Bath & Spa=0": the116BathSpa0 == null ? [] : List<dynamic>.from(the116BathSpa0!.map((x) => x)),
    "108=Fragrances=0": the108Fragrances0 == null ? [] : List<dynamic>.from(the108Fragrances0!.map((x) => x)),
    "115=Eye Makeup=0": the115EyeMakeup0 == null ? [] : List<dynamic>.from(the115EyeMakeup0!.map((x) => x)),
    "169=Nails=0": the169Nails0?.toJson(),
    "106=Hair Care & Styling=0": the106HairCareStyling0 == null ? [] : List<dynamic>.from(the106HairCareStyling0!.map((x) => x)),
    "109=Make up=0": the109MakeUp0 == null ? [] : List<dynamic>.from(the109MakeUp0!.map((x) => x)),
    "113=Lip Care=0": the113LipCare0 == null ? [] : List<dynamic>.from(the113LipCare0!.map((x) => x)),
    "1303=Health & Nutrition=0": the1303HealthNutrition0 == null ? [] : List<dynamic>.from(the1303HealthNutrition0!.map((x) => x)),
    "828=Health Care Devices=0": the828HealthCareDevices0 == null ? [] : List<dynamic>.from(the828HealthCareDevices0!.map((x) => x)),
    "112=Oral Care=0": the112OralCare0 == null ? [] : List<dynamic>.from(the112OralCare0!.map((x) => x)),
  };
}

class The169Nails0 {
  String? the0;
  List<String>? the171NailArt0;

  The169Nails0({
    this.the0,
    this.the171NailArt0,
  });

  factory The169Nails0.fromJson(Map<String, dynamic> json) => The169Nails0(
    the0: json["0"],
    the171NailArt0: json["171=Nail Art=0"] == null ? [] : List<String>.from(json["171=Nail Art=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "171=Nail Art=0": the171NailArt0 == null ? [] : List<dynamic>.from(the171NailArt0!.map((x) => x)),
  };
}

class CatTree1213IndoorGames0 {
  The582Skating0? the582Skating0;

  CatTree1213IndoorGames0({
    this.the582Skating0,
  });

  factory CatTree1213IndoorGames0.fromJson(Map<String, dynamic> json) => CatTree1213IndoorGames0(
    the582Skating0: json["582=Skating=0"] == null ? null : The582Skating0.fromJson(json["582=Skating=0"]),
  );

  Map<String, dynamic> toJson() => {
    "582=Skating=0": the582Skating0?.toJson(),
  };
}

class The582Skating0 {
  List<String>? the583Skate0;

  The582Skating0({
    this.the583Skate0,
  });

  factory The582Skating0.fromJson(Map<String, dynamic> json) => The582Skating0(
    the583Skate0: json["583=Skate=0"] == null ? [] : List<String>.from(json["583=Skate=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "583=Skate=0": the583Skate0 == null ? [] : List<dynamic>.from(the583Skate0!.map((x) => x)),
  };
}

class The1289EyewearCare0 {
  List<String>? the1411EyeWear0;

  The1289EyewearCare0({
    this.the1411EyeWear0,
  });

  factory The1289EyewearCare0.fromJson(Map<String, dynamic> json) => The1289EyewearCare0(
    the1411EyeWear0: json["1411=Eye Wear=0"] == null ? [] : List<String>.from(json["1411=Eye Wear=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1411=Eye Wear=0": the1411EyeWear0 == null ? [] : List<dynamic>.from(the1411EyeWear0!.map((x) => x)),
  };
}

class The1554Vehicles0 {
  List<String>? the1555BikesScooters0;

  The1554Vehicles0({
    this.the1555BikesScooters0,
  });

  factory The1554Vehicles0.fromJson(Map<String, dynamic> json) => The1554Vehicles0(
    the1555BikesScooters0: json["1555=Bikes & Scooters=0"] == null ? [] : List<String>.from(json["1555=Bikes & Scooters=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1555=Bikes & Scooters=0": the1555BikesScooters0 == null ? [] : List<dynamic>.from(the1555BikesScooters0!.map((x) => x)),
  };
}

class The1Clothing0 {
  The228Innerwear0? the228Innerwear0;
  List<String>? the180BottomWear0;
  List<String>? the1441ClothingAccessories0;
  List<String>? the43SportsWear0;

  The1Clothing0({
    this.the228Innerwear0,
    this.the180BottomWear0,
    this.the1441ClothingAccessories0,
    this.the43SportsWear0,
  });

  factory The1Clothing0.fromJson(Map<String, dynamic> json) => The1Clothing0(
    the228Innerwear0: json["228=Innerwear=0"] == null ? null : The228Innerwear0.fromJson(json["228=Innerwear=0"]),
    the180BottomWear0: json["180=Bottom Wear=0"] == null ? [] : List<String>.from(json["180=Bottom Wear=0"]!.map((x) => x)),
    the1441ClothingAccessories0: json["1441=Clothing Accessories=0"] == null ? [] : List<String>.from(json["1441=Clothing Accessories=0"]!.map((x) => x)),
    the43SportsWear0: json["43=Sports Wear=0"] == null ? [] : List<String>.from(json["43=Sports Wear=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "228=Innerwear=0": the228Innerwear0?.toJson(),
    "180=Bottom Wear=0": the180BottomWear0 == null ? [] : List<dynamic>.from(the180BottomWear0!.map((x) => x)),
    "1441=Clothing Accessories=0": the1441ClothingAccessories0 == null ? [] : List<dynamic>.from(the1441ClothingAccessories0!.map((x) => x)),
    "43=Sports Wear=0": the43SportsWear0 == null ? [] : List<dynamic>.from(the43SportsWear0!.map((x) => x)),
  };
}

class The228Innerwear0 {
  String? the0;
  String? the1;
  String? the2;
  String? the3;
  List<String>? the366BrandedInnerwear0;
  List<String>? the1420PlumbingSupplies0;

  The228Innerwear0({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the366BrandedInnerwear0,
    this.the1420PlumbingSupplies0,
  });

  factory The228Innerwear0.fromJson(Map<String, dynamic> json) => The228Innerwear0(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the366BrandedInnerwear0: json["366=Branded Innerwear=0"] == null ? [] : List<String>.from(json["366=Branded Innerwear=0"]!.map((x) => x)),
    the1420PlumbingSupplies0: json["1420=Plumbing Supplies=0"] == null ? [] : List<String>.from(json["1420=Plumbing Supplies=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "366=Branded Innerwear=0": the366BrandedInnerwear0 == null ? [] : List<dynamic>.from(the366BrandedInnerwear0!.map((x) => x)),
    "1420=Plumbing Supplies=0": the1420PlumbingSupplies0 == null ? [] : List<dynamic>.from(the1420PlumbingSupplies0!.map((x) => x)),
  };
}

class The242FashionPersonalAccessories0 {
  List<String>? the1053Branded0;

  The242FashionPersonalAccessories0({
    this.the1053Branded0,
  });

  factory The242FashionPersonalAccessories0.fromJson(Map<String, dynamic> json) => The242FashionPersonalAccessories0(
    the1053Branded0: json["1053=Branded=0"] == null ? [] : List<String>.from(json["1053=Branded=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1053=Branded=0": the1053Branded0 == null ? [] : List<dynamic>.from(the1053Branded0!.map((x) => x)),
  };
}

class The298Furniture0 {
  The79HomeAppliances0? the327LivingRoomFurniture0;
  List<String>? the316BedroomFurniture0;
  List<String>? the339StorageFurniture0;
  List<String>? the322KitchenDining0;
  List<String>? the345StudyOfficeFurniture0;

  The298Furniture0({
    this.the327LivingRoomFurniture0,
    this.the316BedroomFurniture0,
    this.the339StorageFurniture0,
    this.the322KitchenDining0,
    this.the345StudyOfficeFurniture0,
  });

  factory The298Furniture0.fromJson(Map<String, dynamic> json) => The298Furniture0(
    the327LivingRoomFurniture0: json["327=Living Room Furniture=0"] == null ? null : The79HomeAppliances0.fromJson(json["327=Living Room Furniture=0"]),
    the316BedroomFurniture0: json["316=Bedroom Furniture=0"] == null ? [] : List<String>.from(json["316=Bedroom Furniture=0"]!.map((x) => x)),
    the339StorageFurniture0: json["339=Storage Furniture=0"] == null ? [] : List<String>.from(json["339=Storage Furniture=0"]!.map((x) => x)),
    the322KitchenDining0: json["322=Kitchen & Dining=0"] == null ? [] : List<String>.from(json["322=Kitchen & Dining=0"]!.map((x) => x)),
    the345StudyOfficeFurniture0: json["345=Study & Office Furniture=0"] == null ? [] : List<String>.from(json["345=Study & Office Furniture=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "327=Living Room Furniture=0": the327LivingRoomFurniture0?.toJson(),
    "316=Bedroom Furniture=0": the316BedroomFurniture0 == null ? [] : List<dynamic>.from(the316BedroomFurniture0!.map((x) => x)),
    "339=Storage Furniture=0": the339StorageFurniture0 == null ? [] : List<dynamic>.from(the339StorageFurniture0!.map((x) => x)),
    "322=Kitchen & Dining=0": the322KitchenDining0 == null ? [] : List<dynamic>.from(the322KitchenDining0!.map((x) => x)),
    "345=Study & Office Furniture=0": the345StudyOfficeFurniture0 == null ? [] : List<dynamic>.from(the345StudyOfficeFurniture0!.map((x) => x)),
  };
}

class The79HomeAppliances0 {
  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? the5;
  String? the6;
  String? the7;
  String? the8;
  List<String>? the1227BrandedFurniture0;
  String? the9;
  List<String>? the1443BrandedSupport0;
  List<String>? the997BrandedTablewareServeware1;
  List<String>? the865OtherMobileAccessories0;
  List<String>? the1208SmallKitchenAppliances0;
  List<String>? the1209SmallHomeAppliances0;

  The79HomeAppliances0({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the1227BrandedFurniture0,
    this.the9,
    this.the1443BrandedSupport0,
    this.the997BrandedTablewareServeware1,
    this.the865OtherMobileAccessories0,
    this.the1208SmallKitchenAppliances0,
    this.the1209SmallHomeAppliances0,
  });

  factory The79HomeAppliances0.fromJson(Map<String, dynamic> json) => The79HomeAppliances0(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the1227BrandedFurniture0: json["1227=Branded Furniture=0"] == null ? [] : List<String>.from(json["1227=Branded Furniture=0"]!.map((x) => x)),
    the9: json["9"],
    the1443BrandedSupport0: json["1443=Branded Support=0"] == null ? [] : List<String>.from(json["1443=Branded Support=0"]!.map((x) => x)),
    the997BrandedTablewareServeware1: json["997=BrandedTableware & Serveware=1"] == null ? [] : List<String>.from(json["997=BrandedTableware & Serveware=1"]!.map((x) => x)),
    the865OtherMobileAccessories0: json["865=Other Mobile Accessories=0"] == null ? [] : List<String>.from(json["865=Other Mobile Accessories=0"]!.map((x) => x)),
    the1208SmallKitchenAppliances0: json["1208=Small Kitchen Appliances=0"] == null ? [] : List<String>.from(json["1208=Small Kitchen Appliances=0"]!.map((x) => x)),
    the1209SmallHomeAppliances0: json["1209=Small Home appliances=0"] == null ? [] : List<String>.from(json["1209=Small Home appliances=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "1227=Branded Furniture=0": the1227BrandedFurniture0 == null ? [] : List<dynamic>.from(the1227BrandedFurniture0!.map((x) => x)),
    "9": the9,
    "1443=Branded Support=0": the1443BrandedSupport0 == null ? [] : List<dynamic>.from(the1443BrandedSupport0!.map((x) => x)),
    "997=BrandedTableware & Serveware=1": the997BrandedTablewareServeware1 == null ? [] : List<dynamic>.from(the997BrandedTablewareServeware1!.map((x) => x)),
    "865=Other Mobile Accessories=0": the865OtherMobileAccessories0 == null ? [] : List<dynamic>.from(the865OtherMobileAccessories0!.map((x) => x)),
    "1208=Small Kitchen Appliances=0": the1208SmallKitchenAppliances0 == null ? [] : List<dynamic>.from(the1208SmallKitchenAppliances0!.map((x) => x)),
    "1209=Small Home appliances=0": the1209SmallHomeAppliances0 == null ? [] : List<dynamic>.from(the1209SmallHomeAppliances0!.map((x) => x)),
  };
}

class The357SportsFitness0 {
  The79HomeAppliances0? the511FitnessAccessories0;
  Map<String, List<String>>? the1212OutdoorGames0;
  List<String>? the1124Accessories0;
  List<String>? the1004FitnessEquipment0;
  The357SportsFitness01213IndoorGames0? the1213IndoorGames0;

  The357SportsFitness0({
    this.the511FitnessAccessories0,
    this.the1212OutdoorGames0,
    this.the1124Accessories0,
    this.the1004FitnessEquipment0,
    this.the1213IndoorGames0,
  });

  factory The357SportsFitness0.fromJson(Map<String, dynamic> json) => The357SportsFitness0(
    the511FitnessAccessories0: json["511=Fitness Accessories=0"] == null ? null : The79HomeAppliances0.fromJson(json["511=Fitness Accessories=0"]),
    the1212OutdoorGames0: Map.from(json["1212=Outdoor Games=0"]!).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    the1124Accessories0: json["1124=Accessories=0"] == null ? [] : List<String>.from(json["1124=Accessories=0"]!.map((x) => x)),
    the1004FitnessEquipment0: json["1004=Fitness Equipment=0"] == null ? [] : List<String>.from(json["1004=Fitness Equipment=0"]!.map((x) => x)),
    the1213IndoorGames0: json["1213=Indoor Games=0"] == null ? null : The357SportsFitness01213IndoorGames0.fromJson(json["1213=Indoor Games=0"]),
  );

  Map<String, dynamic> toJson() => {
    "511=Fitness Accessories=0": the511FitnessAccessories0?.toJson(),
    "1212=Outdoor Games=0": Map.from(the1212OutdoorGames0!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "1124=Accessories=0": the1124Accessories0 == null ? [] : List<dynamic>.from(the1124Accessories0!.map((x) => x)),
    "1004=Fitness Equipment=0": the1004FitnessEquipment0 == null ? [] : List<dynamic>.from(the1004FitnessEquipment0!.map((x) => x)),
    "1213=Indoor Games=0": the1213IndoorGames0?.toJson(),
  };
}

class The357SportsFitness01213IndoorGames0 {
  List<String>? the480Boxing0;
  List<String>? the582Skating0;
  List<String>? the1126SnookerAndPoolGame0;

  The357SportsFitness01213IndoorGames0({
    this.the480Boxing0,
    this.the582Skating0,
    this.the1126SnookerAndPoolGame0,
  });

  factory The357SportsFitness01213IndoorGames0.fromJson(Map<String, dynamic> json) => The357SportsFitness01213IndoorGames0(
    the480Boxing0: json["480=Boxing=0"] == null ? [] : List<String>.from(json["480=Boxing=0"]!.map((x) => x)),
    the582Skating0: json["582=Skating=0"] == null ? [] : List<String>.from(json["582=Skating=0"]!.map((x) => x)),
    the1126SnookerAndPoolGame0: json["1126=Snooker And Pool Game=0"] == null ? [] : List<String>.from(json["1126=Snooker And Pool Game=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "480=Boxing=0": the480Boxing0 == null ? [] : List<dynamic>.from(the480Boxing0!.map((x) => x)),
    "582=Skating=0": the582Skating0 == null ? [] : List<dynamic>.from(the582Skating0!.map((x) => x)),
    "1126=Snooker And Pool Game=0": the1126SnookerAndPoolGame0 == null ? [] : List<dynamic>.from(the1126SnookerAndPoolGame0!.map((x) => x)),
  };
}

class The370HomeKitchenAccessories0 {
  String? the0;
  List<String>? the450HousekeepingLaundry0;
  List<String>? the390KitchenTools0;
  List<String>? the439HomeKitchenUtility0;
  The79HomeAppliances0? the419TablewareServeware0;
  The381Cookware0? the381Cookware0;

  The370HomeKitchenAccessories0({
    this.the0,
    this.the450HousekeepingLaundry0,
    this.the390KitchenTools0,
    this.the439HomeKitchenUtility0,
    this.the419TablewareServeware0,
    this.the381Cookware0,
  });

  factory The370HomeKitchenAccessories0.fromJson(Map<String, dynamic> json) => The370HomeKitchenAccessories0(
    the0: json["0"],
    the450HousekeepingLaundry0: json["450=Housekeeping & Laundry=0"] == null ? [] : List<String>.from(json["450=Housekeeping & Laundry=0"]!.map((x) => x)),
    the390KitchenTools0: json["390=Kitchen Tools=0"] == null ? [] : List<String>.from(json["390=Kitchen Tools=0"]!.map((x) => x)),
    the439HomeKitchenUtility0: json["439=Home & Kitchen Utility=0"] == null ? [] : List<String>.from(json["439=Home & Kitchen Utility=0"]!.map((x) => x)),
    the419TablewareServeware0: json["419=Tableware & Serveware=0"] == null ? null : The79HomeAppliances0.fromJson(json["419=Tableware & Serveware=0"]),
    the381Cookware0: json["381=Cookware=0"] == null ? null : The381Cookware0.fromJson(json["381=Cookware=0"]),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "450=Housekeeping & Laundry=0": the450HousekeepingLaundry0 == null ? [] : List<dynamic>.from(the450HousekeepingLaundry0!.map((x) => x)),
    "390=Kitchen Tools=0": the390KitchenTools0 == null ? [] : List<dynamic>.from(the390KitchenTools0!.map((x) => x)),
    "439=Home & Kitchen Utility=0": the439HomeKitchenUtility0 == null ? [] : List<dynamic>.from(the439HomeKitchenUtility0!.map((x) => x)),
    "419=Tableware & Serveware=0": the419TablewareServeware0?.toJson(),
    "381=Cookware=0": the381Cookware0?.toJson(),
  };
}

class The381Cookware0 {
  String? the0;
  List<String>? the993BrandedCookware1;

  The381Cookware0({
    this.the0,
    this.the993BrandedCookware1,
  });

  factory The381Cookware0.fromJson(Map<String, dynamic> json) => The381Cookware0(
    the0: json["0"],
    the993BrandedCookware1: json["993=Branded Cookware=1"] == null ? [] : List<String>.from(json["993=Branded Cookware=1"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "993=Branded Cookware=1": the993BrandedCookware1 == null ? [] : List<dynamic>.from(the993BrandedCookware1!.map((x) => x)),
  };
}

class The522TravelProducts0 {
  The523BagsBackpack0? the523BagsBackpack0;

  The522TravelProducts0({
    this.the523BagsBackpack0,
  });

  factory The522TravelProducts0.fromJson(Map<String, dynamic> json) => The522TravelProducts0(
    the523BagsBackpack0: json["523=Bags & Backpack=0"] == null ? null : The523BagsBackpack0.fromJson(json["523=Bags & Backpack=0"]),
  );

  Map<String, dynamic> toJson() => {
    "523=Bags & Backpack=0": the523BagsBackpack0?.toJson(),
  };
}

class The523BagsBackpack0 {
  List<String>? the1055Branded0;

  The523BagsBackpack0({
    this.the1055Branded0,
  });

  factory The523BagsBackpack0.fromJson(Map<String, dynamic> json) => The523BagsBackpack0(
    the1055Branded0: json["1055=Branded=0"] == null ? [] : List<String>.from(json["1055=Branded=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1055=Branded=0": the1055Branded0 == null ? [] : List<dynamic>.from(the1055Branded0!.map((x) => x)),
  };
}

class The58Electronics1 {
  String? the0;
  String? the1;
  List<String>? the1207Other0;
  The79HomeAppliances0? the102MobileAccessories0;
  List<String>? the71CameraPhotography0;
  List<String>? the101HomeTheaterTvVideo0;
  List<String>? the69SmartWearable1;
  List<String>? the1310UsbGadgets0;

  The58Electronics1({
    this.the0,
    this.the1,
    this.the1207Other0,
    this.the102MobileAccessories0,
    this.the71CameraPhotography0,
    this.the101HomeTheaterTvVideo0,
    this.the69SmartWearable1,
    this.the1310UsbGadgets0,
  });

  factory The58Electronics1.fromJson(Map<String, dynamic> json) => The58Electronics1(
    the0: json["0"],
    the1: json["1"],
    the1207Other0: json["1207=Other=0"] == null ? [] : List<String>.from(json["1207=Other=0"]!.map((x) => x)),
    the102MobileAccessories0: json["102=Mobile Accessories=0"] == null ? null : The79HomeAppliances0.fromJson(json["102=Mobile Accessories=0"]),
    the71CameraPhotography0: json["71=Camera & Photography=0"] == null ? [] : List<String>.from(json["71=Camera & Photography=0"]!.map((x) => x)),
    the101HomeTheaterTvVideo0: json["101=Home Theater, TV & Video=0"] == null ? [] : List<String>.from(json["101=Home Theater, TV & Video=0"]!.map((x) => x)),
    the69SmartWearable1: json["69=Smart Wearable=1"] == null ? [] : List<String>.from(json["69=Smart Wearable=1"]!.map((x) => x)),
    the1310UsbGadgets0: json["1310=USB Gadgets=0"] == null ? [] : List<String>.from(json["1310=USB Gadgets=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "1207=Other=0": the1207Other0 == null ? [] : List<dynamic>.from(the1207Other0!.map((x) => x)),
    "102=Mobile Accessories=0": the102MobileAccessories0?.toJson(),
    "71=Camera & Photography=0": the71CameraPhotography0 == null ? [] : List<dynamic>.from(the71CameraPhotography0!.map((x) => x)),
    "101=Home Theater, TV & Video=0": the101HomeTheaterTvVideo0 == null ? [] : List<dynamic>.from(the101HomeTheaterTvVideo0!.map((x) => x)),
    "69=Smart Wearable=1": the69SmartWearable1 == null ? [] : List<dynamic>.from(the69SmartWearable1!.map((x) => x)),
    "1310=USB Gadgets=0": the1310UsbGadgets0 == null ? [] : List<dynamic>.from(the1310UsbGadgets0!.map((x) => x)),
  };
}

class The608HouseFinishingMaterialTools0 {
  The228Innerwear0? the609BathroomFittingSanitary0;
  The621MaterialForFurnitureMaking0? the621MaterialForFurnitureMaking0;
  List<String>? the1131ElectricalHardware0;
  List<String>? the1002SecurityEquipments0;

  The608HouseFinishingMaterialTools0({
    this.the609BathroomFittingSanitary0,
    this.the621MaterialForFurnitureMaking0,
    this.the1131ElectricalHardware0,
    this.the1002SecurityEquipments0,
  });

  factory The608HouseFinishingMaterialTools0.fromJson(Map<String, dynamic> json) => The608HouseFinishingMaterialTools0(
    the609BathroomFittingSanitary0: json["609=Bathroom fitting & Sanitary=0"] == null ? null : The228Innerwear0.fromJson(json["609=Bathroom fitting & Sanitary=0"]),
    the621MaterialForFurnitureMaking0: json["621=Material for Furniture Making=0"] == null ? null : The621MaterialForFurnitureMaking0.fromJson(json["621=Material for Furniture Making=0"]),
    the1131ElectricalHardware0: json["1131=Electrical & Hardware=0"] == null ? [] : List<String>.from(json["1131=Electrical & Hardware=0"]!.map((x) => x)),
    the1002SecurityEquipments0: json["1002=Security Equipments=0"] == null ? [] : List<String>.from(json["1002=Security Equipments=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "609=Bathroom fitting & Sanitary=0": the609BathroomFittingSanitary0?.toJson(),
    "621=Material for Furniture Making=0": the621MaterialForFurnitureMaking0?.toJson(),
    "1131=Electrical & Hardware=0": the1131ElectricalHardware0 == null ? [] : List<dynamic>.from(the1131ElectricalHardware0!.map((x) => x)),
    "1002=Security Equipments=0": the1002SecurityEquipments0 == null ? [] : List<dynamic>.from(the1002SecurityEquipments0!.map((x) => x)),
  };
}

class The621MaterialForFurnitureMaking0 {
  String? the0;
  List<String>? the862BrandedMaterial0;

  The621MaterialForFurnitureMaking0({
    this.the0,
    this.the862BrandedMaterial0,
  });

  factory The621MaterialForFurnitureMaking0.fromJson(Map<String, dynamic> json) => The621MaterialForFurnitureMaking0(
    the0: json["0"],
    the862BrandedMaterial0: json["862=Branded Material=0"] == null ? [] : List<String>.from(json["862=Branded Material=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "862=Branded Material=0": the862BrandedMaterial0 == null ? [] : List<dynamic>.from(the862BrandedMaterial0!.map((x) => x)),
  };
}

class The675HomeDecor0 {
  List<String>? the1059Branded0;
  List<String>? the1262HomeLighting0;

  The675HomeDecor0({
    this.the1059Branded0,
    this.the1262HomeLighting0,
  });

  factory The675HomeDecor0.fromJson(Map<String, dynamic> json) => The675HomeDecor0(
    the1059Branded0: json["1059=Branded=0"] == null ? [] : List<String>.from(json["1059=Branded=0"]!.map((x) => x)),
    the1262HomeLighting0: json["1262=Home Lighting=0"] == null ? [] : List<String>.from(json["1262=Home Lighting=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1059=Branded=0": the1059Branded0 == null ? [] : List<dynamic>.from(the1059Branded0!.map((x) => x)),
    "1262=Home Lighting=0": the1262HomeLighting0 == null ? [] : List<dynamic>.from(the1262HomeLighting0!.map((x) => x)),
  };
}

class The701MusicalInstruments0 {
  List<String>? the702BrassWindInstrument0;
  List<String>? the704Percussion0;

  The701MusicalInstruments0({
    this.the702BrassWindInstrument0,
    this.the704Percussion0,
  });

  factory The701MusicalInstruments0.fromJson(Map<String, dynamic> json) => The701MusicalInstruments0(
    the702BrassWindInstrument0: json["702=Brass & Wind Instrument=0"] == null ? [] : List<String>.from(json["702=Brass & Wind Instrument=0"]!.map((x) => x)),
    the704Percussion0: json["704=Percussion=0"] == null ? [] : List<String>.from(json["704=Percussion=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "702=Brass & Wind Instrument=0": the702BrassWindInstrument0 == null ? [] : List<dynamic>.from(the702BrassWindInstrument0!.map((x) => x)),
    "704=Percussion=0": the704Percussion0 == null ? [] : List<dynamic>.from(the704Percussion0!.map((x) => x)),
  };
}

class The786AutomotiveCareAccessories0 {
  String? the0;
  List<String>? the791BikeAccessories0;
  List<String>? the794CarAccessories0;

  The786AutomotiveCareAccessories0({
    this.the0,
    this.the791BikeAccessories0,
    this.the794CarAccessories0,
  });

  factory The786AutomotiveCareAccessories0.fromJson(Map<String, dynamic> json) => The786AutomotiveCareAccessories0(
    the0: json["0"],
    the791BikeAccessories0: json["791=Bike Accessories=0"] == null ? [] : List<String>.from(json["791=Bike Accessories=0"]!.map((x) => x)),
    the794CarAccessories0: json["794=Car Accessories=0"] == null ? [] : List<String>.from(json["794=Car Accessories=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "791=Bike Accessories=0": the791BikeAccessories0 == null ? [] : List<dynamic>.from(the791BikeAccessories0!.map((x) => x)),
    "794=Car Accessories=0": the794CarAccessories0 == null ? [] : List<dynamic>.from(the794CarAccessories0!.map((x) => x)),
  };
}

class The835IndustrialScientificSupplies0 {
  The838Battery0? the838Battery0;

  The835IndustrialScientificSupplies0({
    this.the838Battery0,
  });

  factory The835IndustrialScientificSupplies0.fromJson(Map<String, dynamic> json) => The835IndustrialScientificSupplies0(
    the838Battery0: json["838=Battery=0"] == null ? null : The838Battery0.fromJson(json["838=Battery=0"]),
  );

  Map<String, dynamic> toJson() => {
    "838=Battery=0": the838Battery0?.toJson(),
  };
}

class The838Battery0 {
  List<String>? the839Branded0;

  The838Battery0({
    this.the839Branded0,
  });

  factory The838Battery0.fromJson(Map<String, dynamic> json) => The838Battery0(
    the839Branded0: json["839=Branded=0"] == null ? [] : List<String>.from(json["839=Branded=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "839=Branded=0": the839Branded0 == null ? [] : List<dynamic>.from(the839Branded0!.map((x) => x)),
  };
}

class The89ToysBabyCare0 {
  List<String>? the1395BabyBathHairSkinCare0;
  List<String>? the1399TricyclesAndRideons0;

  The89ToysBabyCare0({
    this.the1395BabyBathHairSkinCare0,
    this.the1399TricyclesAndRideons0,
  });

  factory The89ToysBabyCare0.fromJson(Map<String, dynamic> json) => The89ToysBabyCare0(
    the1395BabyBathHairSkinCare0: json["1395=Baby Bath, Hair & Skin Care=0"] == null ? [] : List<String>.from(json["1395=Baby Bath, Hair & Skin Care=0"]!.map((x) => x)),
    the1399TricyclesAndRideons0: json["1399=Tricycles and Rideons=0"] == null ? [] : List<String>.from(json["1399=Tricycles and Rideons=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1395=Baby Bath, Hair & Skin Care=0": the1395BabyBathHairSkinCare0 == null ? [] : List<dynamic>.from(the1395BabyBathHairSkinCare0!.map((x) => x)),
    "1399=Tricycles and Rideons=0": the1399TricyclesAndRideons0 == null ? [] : List<dynamic>.from(the1399TricyclesAndRideons0!.map((x) => x)),
  };
}

class The92FootwearAccessories0 {
  List<String>? the243Footwear0;

  The92FootwearAccessories0({
    this.the243Footwear0,
  });

  factory The92FootwearAccessories0.fromJson(Map<String, dynamic> json) => The92FootwearAccessories0(
    the243Footwear0: json["243=Footwear=0"] == null ? [] : List<String>.from(json["243=Footwear=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "243=Footwear=0": the243Footwear0 == null ? [] : List<dynamic>.from(the243Footwear0!.map((x) => x)),
  };
}

class The98ComputersAccessories0 {
  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? the5;
  String? the6;
  List<String>? the1045Software1;
  The63ComputersAccessories0? the63ComputersAccessories0;
  List<String>? the1037ComputerParts0;
  List<String>? the1177LaptopPartsAccessories0;

  The98ComputersAccessories0({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the1045Software1,
    this.the63ComputersAccessories0,
    this.the1037ComputerParts0,
    this.the1177LaptopPartsAccessories0,
  });

  factory The98ComputersAccessories0.fromJson(Map<String, dynamic> json) => The98ComputersAccessories0(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the1045Software1: json["1045=Software=1"] == null ? [] : List<String>.from(json["1045=Software=1"]!.map((x) => x)),
    the63ComputersAccessories0: json["63=Computers Accessories=0"] == null ? null : The63ComputersAccessories0.fromJson(json["63=Computers Accessories=0"]),
    the1037ComputerParts0: json["1037=Computer Parts=0"] == null ? [] : List<String>.from(json["1037=Computer Parts=0"]!.map((x) => x)),
    the1177LaptopPartsAccessories0: json["1177=Laptop Parts & Accessories=0"] == null ? [] : List<String>.from(json["1177=Laptop Parts & Accessories=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "1045=Software=1": the1045Software1 == null ? [] : List<dynamic>.from(the1045Software1!.map((x) => x)),
    "63=Computers Accessories=0": the63ComputersAccessories0?.toJson(),
    "1037=Computer Parts=0": the1037ComputerParts0 == null ? [] : List<dynamic>.from(the1037ComputerParts0!.map((x) => x)),
    "1177=Laptop Parts & Accessories=0": the1177LaptopPartsAccessories0 == null ? [] : List<dynamic>.from(the1177LaptopPartsAccessories0!.map((x) => x)),
  };
}

class The63ComputersAccessories0 {
  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  String? the5;
  String? the6;
  String? the7;
  String? the8;
  String? the9;
  String? the10;
  String? the11;
  String? the12;
  String? the13;
  String? the14;
  List<String>? the1434PrinterSupplies0;

  The63ComputersAccessories0({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.the13,
    this.the14,
    this.the1434PrinterSupplies0,
  });

  factory The63ComputersAccessories0.fromJson(Map<String, dynamic> json) => The63ComputersAccessories0(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"],
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"],
    the13: json["13"],
    the14: json["14"],
    the1434PrinterSupplies0: json["1434=printer Supplies=0"] == null ? [] : List<String>.from(json["1434=printer Supplies=0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5,
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12,
    "13": the13,
    "14": the14,
    "1434=printer Supplies=0": the1434PrinterSupplies0 == null ? [] : List<dynamic>.from(the1434PrinterSupplies0!.map((x) => x)),
  };
}

class ChildCat {
  int? categoryId;
  String? cat;
  String? pcat1;
  String? pcat2;
  String? pcat3;

  ChildCat({
    this.categoryId,
    this.cat,
    this.pcat1,
    this.pcat2,
    this.pcat3,
  });

  factory ChildCat.fromJson(Map<String, dynamic> json) => ChildCat(
    categoryId: json["category_id"],
    cat: json["cat"],
    pcat1: json["pcat1"],
    pcat2: json["pcat2"],
    pcat3: json["pcat3"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "cat": cat,
    "pcat1": pcat1,
    "pcat2": pcat2,
    "pcat3": pcat3,
  };
}

class ProductAccess {
  int? allowedProduct;
  String? success;

  ProductAccess({
    this.allowedProduct,
    this.success,
  });

  factory ProductAccess.fromJson(Map<String, dynamic> json) => ProductAccess(
    allowedProduct: json["allowed_product"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "allowed_product": allowedProduct,
    "success": success,
  };
}
