class StoreFilter {
  StoreFilter({
      this.status,
      this.rateFilter,
      this.categoryFilter,
  });
     String? status;
     List<dynamic>? rateFilter;
     List<CategoryFilter>? categoryFilter;

  StoreFilter.fromJson(Map<String, dynamic> json){
    status = json['status'];
    rateFilter = List.castFrom<dynamic, dynamic>(json['rate_filter']);
    categoryFilter = List.from(json['category_filter']).map((e)=>CategoryFilter.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['rate_filter'] = rateFilter;
    data['category_filter'] = categoryFilter?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class CategoryFilter {
  CategoryFilter({
      this.categoryId,
      this.categoryName,
    this.isSelected,
  });
     String? categoryId;
     String? categoryName;
  bool? isSelected;

  CategoryFilter.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}