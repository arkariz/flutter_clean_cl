import 'package:dio/dio.dart';
import '../data_class/models/error_model.dart';

extension ErrorResponseExtension on Response<dynamic> {

  String get errorMessage {
    final errorResponse = ErrorResponse.fromJson(data);
    return errorResponse.message;
  }
}

extension StringExtension on String {
  String get capitalizeFirst {
    if (isEmpty) {
      return this;
    } else {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
  }
}

extension MergeMapExtension<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V>? map) {
    return {...this, ...?map};
  }
}
