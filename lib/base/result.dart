import '../domain/model/response/error_response.dart';

abstract class Result<T> {}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  final ErrorResponse errorResponse;

  Error(this.errorResponse);
}