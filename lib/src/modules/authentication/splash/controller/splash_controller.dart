import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stackbuffer_test/src/core/repository/database_repository.dart';
import 'package:stackbuffer_test/src/core/services/route_service/app_route_service.dart';
import 'package:stackbuffer_test/src/core/services/user_service/user_service.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/models/user_model.dart';

class SplashController extends GetxController {
  final dbRepo = DatabaseRepository();
  UserService userService = Get.find();

  checkingAuthUser() async {
    try {
      final currentId = FirebaseAuth.instance.currentUser?.uid;
      if (currentId == null) {
        userService.currentUser.value = null;
        Get.offNamed(AppRoutes.login.path);
        return;
      }

      final userMap = await dbRepo.getDocumentById(
        userId: currentId,
        collectionPath: "test_users",
      );

      if (userMap == null) {
        userService.currentUser.value = null;
        Get.offNamed(AppRoutes.login.path);
        return;
      }

      final user = UserModel.fromMap(userMap);
      userService.currentUser.value = user;
      Get.offAllNamed(AppRoutes.homepage.path);
    } catch (e) {
      Get.offNamed(AppRoutes.login.path);
    }
  }
}
