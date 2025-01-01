// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:dio/dio.dart';
import '../base_network_service/interceptors/request_interceptor.dart';
import '../base_network_service/utils/constants.dart';
import '../base_network_service/utils/extensions.dart';

import '../base_network_service/data_class/requests/base_request.dart';
import '../base_network_service/utils/enums.dart';
import '../base_network_service/utils/error_handler.dart';
import '../base_network_service/utils/typedefs.dart';

class BaseService {
  Dio? _dio;

  Dio get dio => _dio!;

  String baseUrl = '';
  Duration receiveTimeout = const Duration(milliseconds: 180 * 1000);
  Duration connectTimeout = const Duration(milliseconds: 180 * 1000);

  JSON headers = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  final JSON _defaultHeader = {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  BaseService({
    Iterable<Interceptor>? additionalInterceptor,
  }) {
    final BaseOptions baseOptions = BaseOptions(
      receiveTimeout: receiveTimeout,
      connectTimeout: connectTimeout,
      receiveDataWhenStatusError: true,
      contentType: Headers.formUrlEncodedContentType,
    );

    _dio = Dio(baseOptions);
    _dio!.interceptors.clear();
    _dio!.interceptors.add(dioRequestInspector.getDioRequestInterceptor());
    if (additionalInterceptor != null) _dio!.interceptors.addAll(additionalInterceptor);
  }

  Future<dynamic> post<T>({
    required String endpoint,
    JSON? data,
    List<JSON>? listData,
    Options? options,
    bool isReturnJson = true,
    JSON? additionalHeaders,
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders == null || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    if (additionalHeaders != null) {
      headers = headers.merge(additionalHeaders);
    }

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response = await _request(
        method: Method.POST,
        endpoint: endpoint,
        data: data,
        listData: listData,
        isReturnJson: isReturnJson);
    return response;
  }

  Future<dynamic> get<T>({
    required String endpoint,
    JSON? data,
    bool isReturnJson = true,
    String url = "", // Apabila url tidak kosong, maka tidak perlu pakai baseUrl
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty || url.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response = await _request(
        method: Method.GET,
        endpoint: endpoint,
        url: url,
        data: data,
        isReturnJson: isReturnJson);
    return response;
  }

  Future<dynamic> put<T>({
    required String endpoint,
    JSON? data,
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response =
        await _request(method: Method.PUT, endpoint: endpoint, data: data);
    return response;
  }

  Future<dynamic> patch<T>({
    required String endpoint,
    JSON? data,
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response =
        await _request(method: Method.PATCH, endpoint: endpoint, data: data);
    return response;
  }

  Future<dynamic> delete<T>({
    required String endpoint,
    JSON? data,
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response =
        await _request(method: Method.DELETE, endpoint: endpoint, data: data);
    return response;
  }

  Future<dynamic> uploadDocumentWithFilePath<T>({
    required String endpoint,
    required String field,
    required String filePath,
    JSON? data,
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(filePath.isNotEmpty && field.isNotEmpty, StringConstant.filePathAndFileRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response = await _request(
        method: Method.MULTIPART,
        endpoint: endpoint,
        data: data,
        field: field,
        filePath: filePath);
    return response;
  }

  Future<dynamic> uploadDocumentWithFileBytes<T>({
    required String endpoint,
    String field = '',
    List<int> fileBytes = const [],
    JSON? data,
    Options? options,
    JSON additionalHeaders = const {},
    JSON? replaceHeaders,
    ContentType contentType = ContentType.image,
  }) async {
    assert(baseUrl.isNotEmpty, StringConstant.baseUrlRequired);
    assert(additionalHeaders.isEmpty || replaceHeaders == null, StringConstant.invalidHeaderParameter);

    headers = headers.merge(additionalHeaders);

    if (replaceHeaders != null) {
      headers = _defaultHeader.merge(replaceHeaders);
    }

    var response;
    response = await _request(
        method: Method.MULTIPART,
        endpoint: endpoint,
        data: data,
        field: field,
        fileBytes: fileBytes,
        contentType: contentType);
    return response;
  }

  void setBaseUrl(String url) {
    baseUrl = url;
  }

  Future<dynamic> _request(
      {required Method method,
      required String endpoint,
      JSON? data,
      List<JSON>? listData,
      String url = "",
      bool isReturnJson = true,
      String field = '',
      String filePath = '',
      List<int> fileBytes = const <int>[],
      ContentType? contentType = ContentType.image , 
      }) async {
    try {
      final BaseRequest baseRequest = BaseRequest();
      final response = await baseRequest.request(
        method: method,
        dio: _dio,
        headers: headers,
        url: url != "" ? url : baseUrl + endpoint,
        data: data ?? {},
        listData: listData,
        isReturnJson: isReturnJson,
        field: field,
        filePath: filePath,
        fileBytes: fileBytes,
        contentType: contentType!,
      );

      return response;
    } on FormatException catch (_) {
      throw Exception(StringConstant.badResponseFormat);
    } on DioException catch (error) {
      handlingError(error);
    }
  }

  void handlingError(DioException error) {
    ErrorHandler.call(error);
  }
}
