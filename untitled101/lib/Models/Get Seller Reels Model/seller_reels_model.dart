// class GetSellerReels {
//   String? status;
//   int? totalPages;
//   String? baseUrl;
//   String? sellerLogo;
//   int? pageNo;
//   String? limit;
//   int? offset;
//   int? count;
//   String? totalCount;
//   List<Data>? data;
//   List<SellerData>? sellerData;
//
//   GetSellerReels(
//       {this.status,
//         this.totalPages,
//         this.baseUrl,
//         this.sellerLogo,
//         this.pageNo,
//         this.limit,
//         this.offset,
//         this.count,
//         this.totalCount,
//         this.data,
//         this.sellerData});
//
//   GetSellerReels.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     totalPages = json['total_pages'];
//     baseUrl = json['base_url'];
//     sellerLogo = json['seller_logo'];
//     pageNo = json['page_no'];
//     limit = json['limit'];
//     offset = json['offset'];
//     count = json['count'];
//     totalCount = json['total_count'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     if (json['sellerData'] != null) {
//       sellerData = <SellerData>[];
//       json['sellerData'].forEach((v) {
//         sellerData!.add(SellerData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['total_pages'] = totalPages;
//     data['base_url'] = baseUrl;
//     data['seller_logo'] = sellerLogo;
//     data['page_no'] = pageNo;
//     data['limit'] = limit;
//     data['offset'] = offset;
//     data['count'] = count;
//     data['total_count'] = totalCount;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (sellerData != null) {
//       data['sellerData'] = sellerData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? postLink;
//   String? thumbnail;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? keyword;
//   String? userId;
//   String? postType;
//   String? category;
//   String? feed;
//   String? likeCount;
//   String? commentCount;
//   String? views;
//   String? isLike;
//   String? isComment;
//
//   Data(
//       {this.id,
//         this.postLink,
//         this.thumbnail,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.keyword,
//         this.userId,
//         this.postType,
//         this.category,
//         this.feed,
//         this.likeCount,
//         this.commentCount,
//         this.views,
//         this.isLike,
//         this.isComment});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     postLink = json['post_link'];
//     thumbnail = json['thumbnail'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     keyword = json['keyword'];
//     userId = json['user_id'];
//     postType = json['post_type'];
//     category = json['category'];
//     feed = json['feed'];
//     likeCount = json['like_count'];
//     commentCount = json['comment_count'];
//     views = json['views'];
//     isLike = json['is_like'];
//     isComment = json['is_comment'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['post_link'] = postLink;
//     data['thumbnail'] = thumbnail;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     data['keyword'] = keyword;
//     data['user_id'] = userId;
//     data['post_type'] = postType;
//     data['category'] = category;
//     data['feed'] = feed;
//     data['like_count'] = likeCount;
//     data['comment_count'] = commentCount;
//     data['views'] = views;
//     data['is_like'] = isLike;
//     data['is_comment'] = isComment;
//     return data;
//   }
// }
//
// class SellerData {
//   String? storeId;
//   String? storeName;
//   String? storeImageUrl;
//
//   SellerData({this.storeId, this.storeName, this.storeImageUrl});
//
//   SellerData.fromJson(Map<String, dynamic> json) {
//     storeId = json['store_id'];
//     storeName = json['store_name'];
//     storeImageUrl = json['store_image_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['store_id'] = storeId;
//     data['store_name'] = storeName;
//     data['store_image_url'] = storeImageUrl;
//     return data;
//   }
// }
