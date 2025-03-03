import 'package:get/get.dart';
import 'package:stackbuffer_test/src/core/services/user_service/user_service.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/controller/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.put(AuthController());
  }
}
