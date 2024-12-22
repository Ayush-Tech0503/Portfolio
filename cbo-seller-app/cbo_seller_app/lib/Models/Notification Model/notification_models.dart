class NotificationModels {
  String? headingText;
  AppLinks? appLinks;
  String? status;
  int? totalPages;
  String? pageNo;
  int? limit;
  int? offset;
  int? count;
  String? totalCount;
  List<Data>? data;

  NotificationModels(
      {this.headingText,
        this.appLinks,
        this.status,
        this.totalPages,
        this.pageNo,
        this.limit,
        this.offset,
        this.count,
        this.totalCount,
        this.data});

  NotificationModels.fromJson(Map<String, dynamic> json) {
    headingText = json['heading_text'];
    appLinks = json['app_links'] != null
        ? AppLinks.fromJson(json['app_links'])
        : null;
    status = json['status'];
    totalPages = json['total_pages'];
    pageNo = json['page_no'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading_text'] = headingText;
    if (appLinks != null) {
      data['app_links'] = appLinks!.toJson();
    }
    data['status'] = status;
    data['total_pages'] = totalPages;
    data['page_no'] = pageNo;
    data['limit'] = limit;
    data['offset'] = offset;
    data['count'] = count;
    data['total_count'] = totalCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppLinks {
  String? andorid;
  String? ios;

  AppLinks({this.andorid, this.ios});

  AppLinks.fromJson(Map<String, dynamic> json) {
    andorid = json['andorid'];
    ios = json['ios'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['andorid'] = andorid;
    data['ios'] = ios;
    return data;
  }
}

class Data {
  String? notificationId;
  String? title;
  String? msg;
  String? userId;
  String? insertDate;

  Data(
      {this.notificationId,
        this.title,
        this.msg,
        this.userId,
        this.insertDate});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    title = json['title'];
    msg = json['msg'];
    userId = json['user_id'];
    insertDate = json['insert_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_id'] = notificationId;
    data['title'] = title;
    data['msg'] = msg;
    data['user_id'] = userId;
    data['insert_date'] = insertDate;
    return data;
  }
}
