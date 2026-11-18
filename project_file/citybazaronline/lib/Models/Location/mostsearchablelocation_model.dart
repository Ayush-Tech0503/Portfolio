class MostSearchableLocation {
  String? status;
  List<LocationDataList>? locationData;

  MostSearchableLocation({this.status, this.locationData});

  MostSearchableLocation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['location'] != null) {
      locationData = <LocationDataList>[];
      json['location'].forEach((v) {
        locationData!.add(new LocationDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.locationData != null) {
      data['location'] = this.locationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationDataList {
  String? id;
  String? locationText;
  String? city;
  String? locationStr;
  String? locationLat;
  String? locationLong;
  String? status;
  String? insertDate;
  String? updateDate;

  LocationDataList(
      {this.id,
        this.locationText,
        this.city,
        this.locationStr,
        this.locationLat,
        this.locationLong,
        this.status,
        this.insertDate,
        this.updateDate});

  LocationDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationText = json['location_text'];
    city = json['city'];
    locationStr = json['location_str'];
    locationLat = json['location_lat'];
    locationLong = json['location_long'];
    status = json['status'];
    insertDate = json['insert_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_text'] = this.locationText;
    data['city'] = this.city;
    data['location_str'] = this.locationStr;
    data['location_lat'] = this.locationLat;
    data['location_long'] = this.locationLong;
    data['status'] = this.status;
    data['insert_date'] = this.insertDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}
