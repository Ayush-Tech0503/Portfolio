class VersionApiModels {
  VersionApiModels({
      this.status,
      this.data,
  });
  late final String? status;
  late final List<Data>? data;

  VersionApiModels.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
      this.version,
      this.statusValue,
  });
  late final String? version;
  late final String? statusValue;

  Data.fromJson(Map<String, dynamic> json){
    version = json['version'];
    statusValue = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['status'] = statusValue;
    return _data;
  }
}