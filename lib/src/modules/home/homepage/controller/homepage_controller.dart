import 'package:get/get.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_strings.dart';
import 'package:stackbuffer_test/src/core/repository/database_repository.dart';
import 'package:stackbuffer_test/src/core/services/route_service/app_route_service.dart';
import 'package:stackbuffer_test/src/core/services/user_service/user_service.dart';
import 'package:stackbuffer_test/src/core/utils.dart';

class HomepageController extends GetxController {
  final UserService userService = Get.find();
  final DatabaseRepository dbRepo = DatabaseRepository();

  logout() async {
    await dbRepo.signOut();
    Utils.showToastBottom(message: AppStrings.signOutSuccessful);
    Get.offAllNamed(AppRoutes.login.path);
  }
}
