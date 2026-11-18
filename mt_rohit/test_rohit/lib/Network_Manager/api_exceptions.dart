class ApiException implements Exception {

  // ignore: prefer_typing_uninitialized_variables
  final _message;

  ApiException([this._message]);

  @override
  String toString() {
    return _message;
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String super.message = ""]);
}

class BadRequestException extends ApiException {
  BadRequestException([super.message]);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([super.message]);
}

class InvalidInputException extends ApiException {
  InvalidInputException([String super.message = ""]);
}

class ServerException extends ApiException {
  ServerException([String super.message = ""]);
}