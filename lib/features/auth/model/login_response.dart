import 'package:gibas/domain/base/model_api.dart';

class LoginResponse extends ModelApi {
  Map<String, dynamic>? userdata;
  String? accessToken;
  String? refreshToken;

  LoginResponse({
    this.userdata,
    this.accessToken,
    this.refreshToken,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userdata = json['userdata'] != null ? Map<String, dynamic>.from(json['userdata']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdata'] = userdata;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
