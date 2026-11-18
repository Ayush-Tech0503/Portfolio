import 'dart:convert';
import 'dart:io';
import 'package:dealshaq/helpers/storage_helper.dart';
import 'package:dealshaq/routes/routes_name.dart';
import 'package:dealshaq/utils/toast_message.dart';
import 'package:http/http.dart' as http;
import '../components/print_value.dart';
import '../models/error_response_model/api_error_response_model.dart';
import 'api_exceptions.dart';

class HttpHelper {
  static final HttpHelper _getInstance = HttpHelper._internal();

  HttpHelper._internal();

  factory HttpHelper() {
    return _getInstance;
  }

  Map<String, String> header (bool isRequireAuthorization) {
    if(isRequireAuthorization){
      return {
        "Content-type": "application/json",
        "lng": StorageHelper().getLocale().languageCode,
        "Authorization": 'Bearer ${StorageHelper().getUserBearerToken()}',
      };
    }else{
      return {
        "Content-type": "application/json",
        "lng": StorageHelper().getLocale().languageCode
      };
    }
  }



  Future<Map<String, dynamic>> get({required String url, bool isRequireAuthorization = false}) async {
    Map<String, dynamic> responseData;

    try {
      final apiResponse = await http.get(Uri.parse(url), headers: header(isRequireAuthorization));

      printValue(url ,tag: "API GET URL: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }
    return responseData;
  }




  Future<Map<String, dynamic>> post(
      {required String url,
        String body ='',
        bool isRequireAuthorization = false}) async {


    Map<String, dynamic> responseData;

    try {
      final apiResponse = await http.post(Uri.parse(url), body: body, headers: header(isRequireAuthorization));

      printValue(url ,tag: "API POST URL: ",);
      printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }

    return responseData;
  }


  Future<Map<String, dynamic>> put(
      {required String url,
        String body = '',
        bool isRequireAuthorization = false}) async {

    Map<String, dynamic> responseData;

    try {
      http.Response apiResponse;

      if (body.isEmpty) {
        apiResponse = await http.put(Uri.parse(url), headers: header(isRequireAuthorization));
      } else {
        apiResponse = await http.put(Uri.parse(url), headers: header(isRequireAuthorization), body: body);
      }


      printValue(url ,tag: "API POST URL: ",);
      printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }
    return responseData;
  }

  Future<Map<String, dynamic>> delete(
      {required String url, bool isRequireAuthorization = false}) async {

    Map<String, dynamic> responseData;

    try {
      final apiResponse =
      await http.delete(Uri.parse(url), headers: header(isRequireAuthorization));

      printValue(url ,tag: "API DELETE URL: ",);
     // printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);
      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }

    return responseData;
  }

  // Future<String> uploadImage(
  //     {File? imageFile, String? url, UploadingStatus? progress}) async {
  //   String response = "";
  //
  //   try {
  //     print("exception=");
  //     var request = MultipartProgress('POST', Uri.parse(url!),
  //         onProgress: (int bytes, int total) {
  //           var progressValue = ((bytes / total) * 100).toInt();
  //           if(progress!=null){
  //             if (progress == UploadingStatus.driverFrontLicense) {
  //               Constants.instance.uploadState?.currentState?.uploadImageBloc.driverFrontUploadSink
  //                   .add(progressValue);
  //             } else if (progress == UploadingStatus.driverFrontLicense) {
  //               Constants.instance.uploadState?.currentState?.uploadImageBloc
  //                   .driverBackUploadeSink
  //                   .add(progressValue);
  //             } else if (progress == UploadingStatus.vehicleRegisteration) {
  //               Constants.instance.uploadState?.currentState?.uploadImageBloc
  //                   .vehicleUploadSink
  //                   .add(progressValue);
  //             }else if (progress == UploadingStatus.otherDocuments) {
  //               Constants.instance.uploadState?.currentState?.uploadImageBloc
  //                   .otherUploadSink
  //                   .add(progressValue);
  //             }
  //           }
  //         });
  //
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'image', imageFile?.path ?? "",
  //         filename: imageFile.toString().split("/").last));
  //
  //     var res = await request.send();
  //     if (res.statusCode == 200) {
  //       response = await res.stream.bytesToString();
  //     } else {
  //       print("exception==${res.statusCode}");
  //       response = "";
  //     }
  //
  //     return response;
  //   } on Exception catch (e) {
  //     print("exception==$e");
  //     return "";
  //   }
  // }


  // Future<String> uploadImageForWeb({Uint8List? byte, String? fileName, String? url}) async {
  //   printValue('API URL: $url');
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(url??""));
  //   Uint8List byteData = byte!;
  //
  //   var byteStream = http.ByteStream.fromBytes(byteData);
  //   var length = byteData.length;
  //   var multipartFile = http.MultipartFile(
  //     'image',
  //     byteStream,
  //     length,
  //     filename: fileName,
  //   );
  //
  //   request.files.add(multipartFile);
  //
  //   String response = "";
  //
  //   final res = await request.send();
  //
  //   try {
  //     if (res.statusCode == 200) {
  //       response = await res.stream.bytesToString();
  //     } else {
  //       response = "null";
  //     }
  //
  //     return response;
  //   } catch (error) {
  //     return "";
  //   }
  // }

// Future<String> uploadImageForWeb(
//     {Uint8List? byte, String? fileName, String? url, UploadingStatus? progress}) async {
//
//   print('Byte: $byte \n || File Name: $fileName \n || url: $url');
//
//   try {
//     print("exception=");
//
//     // var request = MultipartProgress('POST', Uri.parse(url!),
//
//     var request = http.MultipartRequest('POST', Uri.parse(url!));
//     Uint8List? byteData = byte;
//
//     var byteStream = http.ByteStream.fromBytes(byteData!);
//     var length = byteData.length;
//     var multipartFile = http.MultipartFile(
//       'image',
//       byteStream,
//       length,
//       filename: fileName,
//     );
//
//     request.files.add(multipartFile);
//
//     String response = "";
//
//     final res = await request.send();
//
//     print('|| res: ${res.toString()}');
//     print('|| res status code: ${res.statusCode}');
//     try {
//       if (res.statusCode == 200) {
//         response = await res.stream.bytesToString();
//         print('|| response: ${response.toString()}');
//       } else {
//         print('|| response: !200');
//         response = '';
//       }
//
//       return response;
//     } catch (error) {
//       print('|| error');
//       return '';
//     }
//     //     onProgress: (int bytes, int total) {
//     //       var progressValue = ((bytes / total) * 100).toInt();
//     //       if(progress!=null){
//     //         if (progress == UploadingStatus.driverFrontLicense) {
//     //           Constants.instance.uploadState?.currentState?.uploadImageBloc.driverFrontUploadSink
//     //               .add(progressValue);
//     //         } else if (progress == UploadingStatus.driverFrontLicense) {
//     //           Constants.instance.uploadState?.currentState?.uploadImageBloc
//     //               .driverBackUploadeSink
//     //               .add(progressValue);
//     //         } else if (progress == UploadingStatus.vehicleRegisteration) {
//     //           Constants.instance.uploadState?.currentState?.uploadImageBloc
//     //               .vehicleUploadSink
//     //               .add(progressValue);
//     //         }else if (progress == UploadingStatus.otherDocuments) {
//     //           Constants.instance.uploadState?.currentState?.uploadImageBloc
//     //               .otherUploadSink
//     //               .add(progressValue);
//     //         }
//     //       }
//     //     });
//     //
//     // request.files.add(await http.MultipartFile.fromPath(
//     //     'image', imageFile?.path ?? "",
//     //     filename: imageFile.toString().split("/").last));
//     //
//     // var res = await request.send();
//     // if (res.statusCode == 200) {
//     //   response = await res.stream.bytesToString();
//     // } else {
//     //   print("exception==${res.statusCode}");
//     //   response = "";
//     // }
//     //
//     // return response;
//   } on Exception catch (e) {
//     print("exception==$e");
//     return "";
//   }
// }
}

Map<String, dynamic> _returnResponse({required http.Response response}) {
  switch (response.statusCode) {
    case 200:
      var responseJson =
      json.decode(response.body.toString()) as Map<String, dynamic>;
      return responseJson;

    case 201:
      var responseJson =
      json.decode(response.body.toString()) as Map<String, dynamic>;
      return responseJson;

    case 400:
      var decodeError = json.decode(response.body.toString()) as Map<String, dynamic>;
      toastMessage(decodeError['message'].toString());
      throw BadRequestException(response.body.toString());

    case 401:
      StorageHelper().clear(routeName: RouteName.logIn);
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "authorized 401",
          );

     throw UnauthorisedException(json.encode(errorResponse));

    case 403:
      throw InvalidInputException(response.body.toString());

    case 404:
      throw BadRequestException(response.body.toString());

    case 500:
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "Error occurred while Communication with Server with StatusCode 500",);
      toastMessage(errorResponse.message??'');
      throw FetchDataException(json.encode(errorResponse));

    default:
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "Error occurred while Communication with Server with StatusCode ${response.statusCode}",);
      toastMessage(errorResponse.message??'');
      throw FetchDataException(json.encode(errorResponse));
  }
}


/*
FirebaseCrashlytics.instance.setCustomKey('str_key', 'hello');


FirebaseCrashlytics.instance.setCustomKey("int_key", 1);


FirebaseCrashlytics.instance.setCustomKey("int_key", 1);


FirebaseCrashlytics.instance.setCustomKey("float_key", 1.0);


FirebaseCrashlytics.instance.setCustomKey("double_key", 1.0);

throw Exception('this is 7nd Exception');*/
