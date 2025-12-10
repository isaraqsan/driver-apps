class ErrorResponse {
  bool? success;
  int? code;
  String? status;
  String? message;
  dynamic error;

  ErrorResponse({
    this.success,
    this.code,
    this.status,
    this.message,
    this.error,
  });

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['error'] != null) {
      final errorData = json['error'];
      if (errorData is Map) {
        error = errorData.values.first;
      } else if (errorData is bool) {
        error = message;
      } else {
        error = errorData;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;

    return data;
  }
}
