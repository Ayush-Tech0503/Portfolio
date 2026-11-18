// class GetProfileData {
//   String? status;
//   Data? data;
//
//   GetProfileData({this.status, this.data});
//
//   GetProfileData.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? name;
//   String? userId;
//   String? roleId;
//   String? email;
//   String? mobile;
//   String? password;
//   String? address;
//   String? gender;
//   String? dateOfBirth;
//   String? isMobileVerified;
//   String? isSeller;
//   String? mySellerID;
//
//   Data(
//       {this.name,
//         this.userId,
//         this.roleId,
//         this.email,
//         this.mobile,
//         this.password,
//         this.address,
//         this.gender,
//         this.dateOfBirth,
//         this.isMobileVerified,
//         this.isSeller,
//         this.mySellerID});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     userId = json['user_id'];
//     roleId = json['role_id'];
//     email = json['email'];
//     mobile = json['mobile'];
//     password = json['password'];
//     address = json['address'];
//     gender = json['gender'];
//     dateOfBirth = json['date_of_birth'];
//     isMobileVerified = json['is_mobile_verified'];
//     isSeller = json['is_seller'];
//     mySellerID = json['mySellerID'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['user_id'] = userId;
//     data['role_id'] = roleId;
//     data['email'] = email;
//     data['mobile'] = mobile;
//     data['password'] = password;
//     data['address'] = address;
//     data['gender'] = gender;
//     data['date_of_birth'] = dateOfBirth;
//     data['is_mobile_verified'] = isMobileVerified;
//     data['is_seller'] = isSeller;
//     data['mySellerID'] = mySellerID;
//     return data;
//   }
// }


class GetProfileData {
  String? status;
  Data? data;

  GetProfileData({this.status, this.data});

  GetProfileData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? userId;
  String? roleId;
  String? email;
  String? mobile;
  String? password;
  String? address;
  String? gender;
  String? dateOfBirth;
  String? isMobileVerified;
  String? isSeller;
  String? mySellerID;

  Data({
    this.name,
    this.userId,
    this.roleId,
    this.email,
    this.mobile,
    this.password,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.isMobileVerified,
    this.isSeller,
    this.mySellerID,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    roleId = json['role_id'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    address = json['address'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    isMobileVerified = json['is_mobile_verified'];
    isSeller = json['is_seller'];
    mySellerID = json['mySellerID'];

    // Null check and handling
    name ??= ""; // Assign empty string if name is null
    userId ??= "";
    roleId ??= "";
    email ??= "";
    mobile ??= "";
    password ??= "";
    address ??= "";
    gender ??= "";
    dateOfBirth ??= "";
    isMobileVerified ??= "";
    isSeller ??= "";
    mySellerID ??= "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = password;
    data['address'] = address;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['is_mobile_verified'] = isMobileVerified;
    data['is_seller'] = isSeller;
    data['mySellerID'] = mySellerID;
    return data;
  }
}
