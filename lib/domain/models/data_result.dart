import 'package:gibas/core/app/constant/response_status.dart';
import 'package:gibas/domain/models/page_info.dart';

enum DataSource { api, localDb, cache, unknown, automatic }

class DataResult<T> {
  T? data;
  List<T>? list;
  String? code;
  String? message;
  late ResponseStatus status;
  late DataSource source;
  PageInfo? pageInfo;

  DataResult({
    this.data,
    this.list,
    this.code,
    this.message,
    this.status = ResponseStatus.unknown,
    this.source = DataSource.unknown,
    this.pageInfo,
  });

  bool get isSuccess => status == ResponseStatus.success;

  factory DataResult.fromJson(
    Map<String, dynamic> json, {
    Function(Map<String, dynamic>)? fromJsonT,
  }) {
    final String? resonseCode =
        json['status']?.toString() ?? json['response_code'];
    final String? responseMessage = json['message'] ?? json['response_message'];
    final PageInfo? pageInfo =
        json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
    if (json['data'] is List) {
      final dataListJson = <T>[];
      json['data'].forEach((v) {
        dataListJson.add(fromJsonT!(v));
      });
      return DataResult<T>(
        code: resonseCode,
        message: responseMessage,
        list: dataListJson,
        source: DataSource.api,
        status: statusFromApi(resonseCode),
        pageInfo: pageInfo,
      );
    } else if (fromJsonT != null) {
      return DataResult<T>(
        code: resonseCode,
        message: responseMessage,
        data: json['data'] != null ? fromJsonT(json['data']) : null,
        source: DataSource.api,
        status: statusFromApi(resonseCode),
        pageInfo: pageInfo,
      );
    } else {
      return DataResult<T>(
        code: resonseCode,
        message: responseMessage,
        data: json['data'],
        source: DataSource.api,
        status: statusFromApi(resonseCode),
        pageInfo: pageInfo,
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['response_code'] = code;
    data['response_message'] = message;
    return data;
  }

  DataResult.fromHive({
    required T dataValue,
    ResponseStatus responseStatus = ResponseStatus.success,
    String messageValue = '',
  }) {
    data = dataValue;
    status = responseStatus;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.fromHiveList({
    required List<T> dataValue,
    ResponseStatus responseStatus = ResponseStatus.success,
    String messageValue = '',
  }) {
    list = dataValue;
    status = responseStatus;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.fromHiveSuccess({
    required T dataValue,
    String messageValue = 'Sukses menyimpan data',
  }) {
    data = dataValue;
    status = ResponseStatus.success;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.fromHiveFailure({
    T? dataValue,
    String messageValue = 'Internal Error',
  }) {
    data = dataValue;
    status = ResponseStatus.failed;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.fromHiveEmpty({
    T? dataValue,
    String messageValue = '',
  }) {
    data = dataValue;
    status = ResponseStatus.dataEmpty;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.fromHiveNotFound({
    T? dataValue,
    String messageValue = '',
  }) {
    data = dataValue;
    status = ResponseStatus.dataNotFound;
    source = DataSource.localDb;
    code = status.code;
    message = messageValue;
  }

  DataResult.success({
    T? dataValue,
    List<T>? listValue,
    String messageValue = 'Berhasil menyimpan data',
  }) {
    data = dataValue;
    list = listValue;
    status = ResponseStatus.success;
    source = DataSource.api;
    code = status.code;
    message = messageValue;
  }

  DataResult.failed({String messageValue = ''}) {
    status = ResponseStatus.failed;
    source = DataSource.unknown;
    code = status.code;
    message = messageValue;
  }

  static ResponseStatus statusFromApi(String? code) {
    return ResponseStatus.fromCode(code);
  }

  @override
  String toString() {
    return 'DataResult{data: $data, code: $code, message: $message, status: $status, source: $source}';
  }

  DataResult<U> copyWith<U>({
    U? data,
    List<U>? list,
    String? code,
    String? message,
    ResponseStatus? status,
    DataSource? source,
  }) {
    return DataResult(
      data: data,
      list: list,
      code: code ?? this.code,
      message: message ?? this.message,
      status: status ?? this.status,
      source: source ?? this.source,
    );
  }
}
