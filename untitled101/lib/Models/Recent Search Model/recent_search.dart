class RecentSearchData {
  RecentSearchData({
     this.status,
     this.searchedKey,
  });

   String? status;
   List<SearchedKey>? searchedKey;

  RecentSearchData.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        searchedKey = (json['searched_key'] as List<dynamic>?)
            ?.map((e) => SearchedKey.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['searched_key'] = searchedKey?.map((e) => e.toJson()).toList();
    return data;
  }
}

class SearchedKey {
  SearchedKey({
    required this.searchKeyword,
  });

   String? searchKeyword;

  SearchedKey.fromJson(Map<String, dynamic> json)
      : searchKeyword = json['search_keyword'] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['search_keyword'] = searchKeyword;
    return data;
  }
}
