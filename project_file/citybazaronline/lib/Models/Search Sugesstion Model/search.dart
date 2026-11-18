class SearchData {
  SearchData({
         this.data,
         this.status,
  });
    List<DataSearchSug>? data;
    String? status;

  SearchData.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>DataSearchSug.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data?.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class DataSearchSug {
  DataSearchSug({
         this.id,
         this.value,
  });
    dynamic id;
    dynamic value;

  DataSearchSug.fromJson(Map<String, dynamic> json){
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['value'] = value;
    return _data;
  }
}

// class SearchData {
//   SearchData({
//          this.data,
//          this.status,
//   });
//     List<DataSearchSug> data;
//     String status;
//
//   SearchData.fromJson(Map<String, dynamic> json){
//     data = List.from(json['data']).map((e)=>DataSearchSug.fromJson(e)).toList();
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     _data['status'] = status;
//     return _data;
//   }
// }
//
// class DataSearchSug {
//   DataSearchSug({
//          this.id,
//          this.value,
//   });
//     int id;
//     String value;
//
//   DataSearchSug.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['value'] = value;
//     return _data;
//   }
// }
