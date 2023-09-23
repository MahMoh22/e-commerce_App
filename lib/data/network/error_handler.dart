import 'package:dio/dio.dart';
import 'package:e_commerce_app/data/network/failure.dart';
import 'package:e_commerce_app/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handler(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIVE_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.UNAUTHORISED.getFailure();
    case DioExceptionType.badResponse:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();

    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIVE_TIMEOUT, ResponseMessage.RECIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int FORBIDDEN = 401; // failure, user is not authorised
  static const int UNAUTHORISED = 403; // failure, API rejected request
  static const int NOT_FOUND = 404; // not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in sever side
  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS = AppStrings.success.tr(); // success with data
  static String NO_CONTENT = AppStrings.noContent.tr(); // success with no data
  static String BAD_REQUEST =
      AppStrings.badRequestError.tr(); // failure, API rejected request
  static String FORBIDDEN =
      AppStrings.forbiddenError.tr(); // failure, user is not authorised
  static String UNAUTHORISED =
      AppStrings.unauthorizedError.tr(); // failure, API rejected request
  static String NOT_FOUND = AppStrings.notFoundError.tr(); // not found
  static String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError.tr(); // failure, crash in sever side
  // local status code
  static String CONNECT_TIMEOUT = AppStrings.timeoutError.tr();
  static String CANCEL = AppStrings.defaultError.tr();
  static String RECIVE_TIMEOUT = AppStrings.timeoutError.tr();
  static String SEND_TIMEOUT = AppStrings.timeoutError.tr();
  static String CACHE_ERROR = AppStrings.cacheError.tr();
  static String NO_INTERNET_CONNECTION = AppStrings.noInternetError.tr();
  static String DEFAULT = AppStrings.defaultError.tr();
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
