class ReelsData {
  ReelsData({
    this.status,
    this.totalPages,
    this.pageNo,
    this.baseUrl,
    this.limit,
    this.offset,
    this.count,
    this.totalCount,
    this.data,
  });
      String? status;
      int? totalPages;
      int? pageNo;
      String? baseUrl;
      String? limit;
      int? offset;
      int? count;
      String? totalCount;
      List<DataReels>? data;

  ReelsData.fromJson(Map<String, dynamic>? json)
      : status = json?['status'],
        totalPages = json?['total_pages'],
        pageNo = json?['page_no'],
        baseUrl = json?['base_url'],
        limit = json?['limit'],
        offset = json?['offset'],
        count = json?['count'],
        totalCount = json?['total_count'],
        data = (json?['data'] as List<dynamic>?)
            ?.map((e) => DataReels.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
       final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['total_pages'] = totalPages;
    _data['page_no'] = pageNo;
    _data['base_url'] = baseUrl;
    _data['limit'] = limit;
    _data['offset'] = offset;
    _data['count'] = count;
    _data['total_count'] = totalCount;
    _data['data'] = data?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataReels {
  DataReels({
    this.id,
    this.userId,
    this.postLink,
    this.postType,
    this.category,
    this.thumbnail,
    this.status,
    this.createdAt,
    this.keyword,
    this.deletedAt,
    this.feed,
    this.storeId,
    this.storeName,
    this.storeImageUrl,
    this.share,
    this.likeCount,
    this.commentCount,
    this.views,
    this.isLike,
    this.isComment,
  });
      String? id;
      String? userId;
      String? postLink;
      String? thumbnail;
      String? postType;
      String? category;
      String? status;
      String? createdAt;
      String? keyword;
      String? deletedAt;
      String? feed;
      String? storeId;
      String? storeName;
      String? storeImageUrl;
      String? share;
      String? likeCount;
      String? commentCount;
      String? views;
      String? isLike;
      String? isSave;
      String? isFollow;
      String? isComment;

  DataReels.fromJson(Map<String, dynamic>? json)
      : id = json?['id'],
        userId = json?['user_id'],
        postLink = json?['post_link'],
        thumbnail = json?['thumbnail'],
        postType = json?['post_type'],
        category = json?['category'],
        status = json?['status'],
        createdAt = json?['created_at'],
        keyword = json?['keyword'],
        deletedAt = json?['deleted_at'],
        feed = json?['feed'],
        storeId = json?['store_id'],
        storeName = json?['store_name'],
        storeImageUrl = json?['store_image_url'],
        share = json?['share'],
        likeCount = json?['like_count'],
        commentCount = json?['comment_count'],
        views = json?['views'],
        isLike = json?['is_like'],
        isSave = json?['is_save'],
        isFollow = json?['is_follow'],
        isComment = json?['is_comment'];

  Map<String, dynamic> toJson() {
     final   data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_link'] = postLink;
     data['thumbnail'] = thumbnail;
    data['post_type'] = postType;
    data['category'] = category;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['keyword'] = keyword;
    data['deleted_at'] = deletedAt;
    data['feed'] = feed;
    data['store_name'] = storeName;
    data['store_image_url'] = storeImageUrl;
    data['store_id'] = storeId;
    data['share'] = share;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['views'] = views;
    data['is_like'] = isLike;
    data['is_save'] = isSave;
    data['is_follow'] = isFollow;
    data['is_comment'] = isComment;
    return data;
  }
}
