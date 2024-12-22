class ShopReviewRatingModel {
  dynamic? status;
  DataR? data;
  dynamic? totalPages;
  dynamic? pageNo;
  dynamic? limit;
  dynamic? offset;
  dynamic? count;
  dynamic? totalCount;

  ShopReviewRatingModel(
      {this.status,
        this.data,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount});

  ShopReviewRatingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataR.fromJson(json['data']) : null;
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total_pages'] = totalPages;
    data['page_no'] = pageNo;
    data['limit'] = limit;
    data['offset'] = offset;
    data['count'] = count;
    data['total_count'] = totalCount;
    return data;
  }
}

class DataR {
  Rating? rating;
  StarRatingCount? starRatingCount;
  List<Reveiws>? reveiws;

  DataR({this.rating, this.starRatingCount, this.reveiws});

  DataR.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    starRatingCount = json['StarRatingCount'] != null
        ? StarRatingCount.fromJson(json['StarRatingCount'])
        : null;
    if (json['reveiws'] != null) {
      reveiws = <Reveiws>[];
      json['reveiws'].forEach((v) {
        reveiws!.add(Reveiws.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (starRatingCount != null) {
      data['StarRatingCount'] = starRatingCount!.toJson();
    }
    if (reveiws != null) {
      data['reveiws'] = reveiws!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  String? avgRating;

  Rating({this.avgRating});

  Rating.fromJson(Map<String, dynamic> json) {
    avgRating = json['avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_rating'] = avgRating;
    return data;
  }
}

class StarRatingCount {
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;
  int? all;

  StarRatingCount({this.i1, this.i2, this.i3, this.i4, this.i5, this.all});

  StarRatingCount.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    data['all'] = all;
    return data;
  }
}

class Reveiws {
  dynamic? user;
  dynamic? userId;
  dynamic? reveiw;
  dynamic? createdDate;
  dynamic? rating;

  Reveiws({this.user, this.userId, this.reveiw, this.createdDate, this.rating});

  Reveiws.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userId = json['user_id'];
    reveiw = json['reveiw'];
    createdDate = json['created_date'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['user_id'] = userId;
    data['reveiw'] = reveiw;
    data['created_date'] = createdDate;
    data['rating'] = rating;
    return data;
  }
}
