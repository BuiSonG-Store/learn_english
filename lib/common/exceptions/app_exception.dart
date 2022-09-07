import 'package:learn_english/common/constants/string_const.dart';

class AppException implements Exception {

  /// message return from server
  String message;

  final int? errorCode;

  /// message internal want to log to server
  String? errorText;


  AppException(
      {this.message = StringConst.someThingWentWrong,
      this.errorCode,
      this.errorText});
}

