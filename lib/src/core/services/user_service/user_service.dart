import 'package:get/get.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/models/user_model.dart';

class UserService extends GetxController {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
}
