import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/global/model/province.dart';
import 'package:gibas/features/register/model/register_request.dart';

class RegisterRepository extends Repository {
  Future<DataResult<Province>> registerUser(RegisterRequest request) async {
    final data = await request.toMultipartMap();

    return await dioService.postMultipart(
      url: Endpoint.register,
      data: data,
      loading: true,
      fromJsonT: (data) => Province.fromJson(data),
    );
  }
}
