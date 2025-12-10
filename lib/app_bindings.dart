import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/app/controller/master_controller.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() async {
    Log.v('Start Bindings', tag: runtimeType.toString());
    //* Dependency Injection
    Get.put(OverlayController());
    Get.put(AuthController());
    Get.put(MasterController());
    
    Log.v('Finish Bindings', tag: runtimeType.toString());
  }
}
