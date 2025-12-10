import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/model/login_request.dart';
import 'package:gibas/features/auth/model/login_response.dart';

class AuthRepository extends Repository {
  Future<DataResult<LoginResponse>> login(LoginRequest body) async {
    return await dioService.post(
      url: Endpoint.login,
      body: body.toJson(),
      loading: true,
      fromJsonT: (data) => LoginResponse.fromJson(data),
    );
  }

  Future<DataResult<Auth>> profile() async {
    return await dioService.get(
      url: Endpoint.profile,
      loading: true,
      fromJsonT: (data) => Auth.fromJson(data),
    );
  }

  Future<DataResult<LoginResponse>> verifyAccount(String confirmHash) async {
    final params = {
      'confirm_hash': confirmHash,
    };

    return await dioService.get(
      url: Endpoint.verify,
      param: params, // <-- pakai param di sini
      loading: true,
      fromJsonT: (data) => LoginResponse.fromJson(data),
    );
  }

  Future<DataResult<LoginResponse>> approvalAccount(
    String confirmHash,
    String status,
    String jabatan,
    String? noRegister,
  ) async {
    final params = {
      'confirm_hash': confirmHash,
      'status': status,
      'jabatan_id': jabatan,
    };

    if (noRegister?.isNotEmpty == true) {
      params['nomor_registrasi'] = noRegister ?? '';
    }

    return await dioService.post(
      url: Endpoint.approval,
      body: params,
      loading: true,
      fromJsonT: (data) => LoginResponse.fromJson(data),
    );
  }
}
