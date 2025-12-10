import 'dart:convert';
import 'dart:io';
import 'package:gibas/core/app/endpoint.dart';
import 'package:gibas/core/utils/error_handling.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/domain/models/data_result.dart';
import 'package:gibas/domain/models/osm_location_response.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gibas/core/app/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:gibas/core/service/env_service.dart';

class DioService extends getx.GetxService {
  final Dio _dio = Dio();
  bool _isLoading = false;

  Future<DioService> init() async {
    final EnvService envService = EnvService();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
      ),
    );
    _dio.options = BaseOptions(
      baseUrl: envService.baseURL(),
      connectTimeout: AppConfig.timeRequestApi,
      receiveTimeout: AppConfig.timeRequestApi,
      sendTimeout: AppConfig.timeRequestApi,
      headers: {
        'Cache-Control': AppConfig.cacheControl,
        'Content-Type': AppConfig.contentTypeJson,
        'Accept': AppConfig.contentTypeJson,
      },
      validateStatus: (status) {
        // Anggap 200 sampai 404 sebagai "valid response"
        return status != null && status <= 404;
      },
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          error: envService.debug,
          request: envService.debug,
          requestBody: envService.debug,
          requestHeader: envService.debug,
          responseBody: envService.debug,
          responseHeader: envService.debug,
          compact: envService.debug,
        ),
      );
    } else {
      _dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
        error: false,
      ));
    }
    return this;
  }

  Future<bool> checkConnectivity() async {
    bool connect = false;
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(AppConfig.timeRequestApi);
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        connect = true;
      }
    } on SocketException catch (_) {
      connect = false;
    }
    return connect;
  }

  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isLoading) OverlayController.to.showLoading();
    return handler.next(options);
  }

  Future<void> onResponse(Response? response, handler) async {
    if (_isLoading) OverlayController.to.hide();

    try {
      // ✅ Cek kalau server return 404 + message "Data not found"
      if (response?.statusCode == 404) {
        final data = response?.data;

        if (data is Map && data['message'] == 'Data not found') {
          Log.i('Data kosong, tidak dianggap error',
              tag: runtimeType.toString());

          // Ubah response biar konsisten, misalnya jadi list kosong
          response?.data = {
            "status": true,
            "message": "Data kosong",
            "result": [],
          };

          return handler.next(response);
        }
      }

      final data = response?.data;

      if (data == null) {
        Log.e('Response data null', tag: runtimeType.toString());
        ErrorHandling.errorApi(
          DataResult.failed(
              messageValue:
                  'Terjadi kesalahan, data tidak ditemukan dari server'),
        );
        if (data is! Map) {
          ErrorHandling.errorApi(
            DataResult.failed(
                messageValue: 'Format data dari server tidak sesuai'),
          );
          response?.data = ErrorHandling.defaultError();
          return handler.next(response);
        } else {
          response?.data = ErrorHandling.defaultError();
          return handler.next(response);
        }
      }
    } catch (e, stack) {
      Log.e('onResponse error: $e', tag: runtimeType.toString());
      Log.e(stack.toString(), tag: runtimeType.toString());

      ErrorHandling.errorApi(
        DataResult.failed(
            messageValue:
                'Terjadi kesalahan saat memproses respon dari server'),
      );
    }

    return handler.next(response);
  }

  Future<void> onError(
      DioException dioError, ErrorInterceptorHandler handler) async {
    OverlayController.to.hide();

    Log.w('Error => ${dioError.message}', tag: runtimeType.toString());

    switch (dioError.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        Utils.toast('Request Time Out', snackType: SnackType.error);
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        Utils.toast('Tidak dapat terhubung', snackType: SnackType.error);
        break;
      case DioExceptionType.badResponse:
        Log.e('Error Bad Response => ${dioError.response!.data}',
            tag: runtimeType.toString());
        late DataResult dataResult;
        if (dioError.response!.data is Map) {
          dataResult = DataResult.fromJson(dioError.response!.data);
        } else if (dioError.response!.data is String) {
          dataResult = DataResult.fromJson(
              jsonDecode(dioError.response!.data.toString()));
        }
        ErrorHandling.errorApi(dataResult);
        break;
      case DioExceptionType.cancel:
        break;
    }

    return handler.next(dioError);
  }

  Future<DataResult<T>> post<T>({
    required String url,
    Map<String, dynamic>? body,
    bool loading = false,
    T Function(Map<String, dynamic> data)? fromJsonT,
  }) async {
    _isLoading = loading;
    final response = await _dio.post(url, data: body).onError(onErrorHandling);
    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  Future<DataResult<T>> put<T>({
    required String url,
    Map<String, dynamic>? body,
    bool loading = false,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) async {
    _isLoading = loading;
    final response = await _dio.put(url, data: body).onError(onErrorHandling);
    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  Future<DataResult<T>> putFormData<T>({
    required String url,
    Object? data,
    bool loading = false,
    T Function(Map<String, dynamic> data)? fromJsonT,
  }) async {
    _isLoading = loading;
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    final response = await _dio.put(url, data: data).onError(onErrorHandling);
    _dio.options.headers['Content-Type'] = AppConfig.contentTypeJson;
    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  Future<DataResult<T>> putMultipart<T>({
    required String url,
    required Map<String, dynamic> data,
    bool loading = false,
    T Function(Map<String, dynamic> data)? fromJsonT,
  }) async {
    _isLoading = loading;
    // simpan Content-Type lama
    final oldContentType = _dio.options.headers['Content-Type'];
    _dio.options.headers['Content-Type'] = 'multipart/form-data';

    final formData = FormData.fromMap(data);

    final response =
        await _dio.put(url, data: formData).onError(onErrorHandling);

    // kembalikan Content-Type lama
    _dio.options.headers['Content-Type'] = oldContentType;

    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  /// Helper untuk konversi File -> MultipartFile
  Future<MultipartFile> multipartFile(File file) async {
    return await MultipartFile.fromFile(file.path,
        filename: file.uri.pathSegments.last);
  }

  Future<DataResult<T>> postMultipart<T>({
    required String url,
    required Map<String, dynamic> data,
    bool loading = false,
    T Function(Map<String, dynamic> data)? fromJsonT,
  }) async {
    _isLoading = loading;
    final oldContentType = _dio.options.headers['Content-Type'];

    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    final formData = FormData.fromMap(data);

    final response =
        await _dio.post(url, data: formData).onError(onErrorHandling);

    _dio.options.headers['Content-Type'] = oldContentType;

    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  Future<DataResult<T>> delete<T>({
    required String url,
    Map<String, dynamic>? body,
    bool useToken = true,
    bool loading = false,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) async {
    _isLoading = loading;
    final response =
        await _dio.delete(url, data: body).onError(onErrorHandling);
    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  Future<DataResult<T>> get<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? param,
    Function(Map<String, dynamic> data)? fromJsonT,
    bool loading = false,
  }) async {
    _isLoading = loading;
    final response = await _dio
        .get(url, data: body, queryParameters: param)
        .onError(onErrorHandling);
    return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  }

  // Future<DataResult<T>> getArea<T>({
  //   required String url,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? param,
  //   Function(Map<String, dynamic> data)? fromJsonT,
  //   bool loading = false,
  // }) async {
  //   final EnvService envService = EnvService();
  //   _isLoading = loading;
  //   _dio.options.baseUrl = envService.baseUrlCms;
  //   final response = await _dio.get(url, data: body, queryParameters: param).onError(onErrorHandling);
  //   _dio.options.baseUrl = envService.baseURL();
  //   return DataResult<T>.fromJson(response.data, fromJsonT: fromJsonT);
  // }

  Future<DataResult<T>> postFormData<T>({
    required String url,
    Object? data,
    bool loading = false,
  }) async {
    _isLoading = loading;
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    final response = await _dio.post(url, data: data).onError(onErrorHandling);
    _dio.options.headers['Content-Type'] = AppConfig.contentTypeJson;
    return DataResult<T>.fromJson(response.data);
  }

  Future<dynamic> head() async {
    final dio = Dio();
    return await dio.head<dynamic>(
      'https://www.google.com',
      options: Options(receiveTimeout: const Duration(seconds: 3)),
    );
  }

  Future download({
    required String url,
    required String ext,
    Map<String, dynamic>? body,
    bool useToken = true,
    Map<String, dynamic>? param,
    bool loading = false,
    bool showMessage = true,
  }) async {
    final Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final String filePath =
        '${appDocDirectory.path}/${url.split('/').last}_${DateTime.now().millisecondsSinceEpoch}.$ext';
    await _dio.download(url, filePath, data: body, queryParameters: param);
    return filePath;
  }

  Future<Response<dynamic>> onErrorHandling(
      Object error, StackTrace stackTrace) async {
    if (error is DioException) {
      return error.response!;
    } else {
      return Future.error(error);
    }
  }

  Future<OSMLocationResponse?> getOSMLocation(double lat, double lon) async {
    final Dio dioOsm = Dio(
      BaseOptions(
        baseUrl: Endpoint.baseUrlOsmLocation,
        headers: {
          'Accept': AppConfig.contentTypeJson,
          'User-Agent': AppConfig.aplicationName,
        },
      ),
    );
    dioOsm.interceptors.add(
      PrettyDioLogger(),
    );
    final response =
        await dioOsm.get('/reverse?format=json&lat=$lat&lon=$lon&zoom=18');
    return OSMLocationResponse.fromJson(response.data);
  }

  Future<List<OSMLocationResponse>> getOSMSearchLocation(String query) async {
    if (!(await checkConnectivity())) {
      return [];
    }
    final Dio dioOsm = Dio(
      BaseOptions(
        baseUrl: Endpoint.baseUrlOsmLocation,
        headers: {
          'Accept': AppConfig.contentTypeJson,
          'User-Agent': AppConfig.aplicationName,
        },
      ),
    );
    dioOsm.interceptors.add(
      PrettyDioLogger(),
    );
    final response = await dioOsm
        .get('/search?q=$query&format=json&addressdetails=1&limit=5');
    return (response.data as List)
        .map((e) => OSMLocationResponse.fromJson(e))
        .toList();
  }

  void setAuthToken(String token) {
    Log.v('Set Auth Token => $token', tag: runtimeType.toString());
    _dio.options.headers['X-Authorization'] = 'Bearer $token';
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('X-Authorization');
    _dio.options.headers.remove('Authorization');
    Log.v('Clear Auth Token', tag: runtimeType.toString());
  }
}
