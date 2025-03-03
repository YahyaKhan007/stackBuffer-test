import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stackbuffer_test/main.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_loadings.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/models/user_model.dart';

import '../../../../core/repository/database_repository.dart';
import '../../../../core/services/route_service/app_route_service.dart';
import '../../../../core/services/user_service/user_service.dart';

class AuthController extends GetxController {
  final dbRepo = DatabaseRepository();
  UserService userService = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  performSignIn() async {
    AppLoadings.showOverlayLoading();
    try {
      final user = await dbRepo.loginWithEmailPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user == null) return;

      final userData = await dbRepo.getDocumentById(
        userId: user.uid,
        collectionPath: "test_users",
      );
      if (userData == null) return;

      final loggedInUser = UserModel.fromMap(userData);
      userService.currentUser.value = loggedInUser;

      Get.offAllNamed(AppRoutes.homepage.path);
    } catch (e, stackTrace) {
      debugPrint("Error : $e");
      debugPrint("stackTrace : $stackTrace");
    } finally {
      AppLoadings.hideOverlayLoading();
    }
  }

  performSignUp() async {
    AppLoadings.showOverlayLoading();
    try {
      final user = await dbRepo.signupWithEmailPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user == null) return;

      UserModel newUser = UserModel(
        userId: user.uid,
        name: "testUser",
        email: emailController.text.trim(),
        phoneNumber: "",
        profilePicture: "",
        tokens: "",
        location: "",
        createdAt: DateTime.now(),
      );

      // Save the new user to Firestore
      await dbRepo.addDataOnSpecificId(
        collectionPath: "test_users",
        data: newUser.toMap(),
        // Assuming you have a toMap() method in UserModel
        documentId: user.uid,
      );

      // Now fetch the user data from Firestore
      final userData = await dbRepo.getDocumentById(
        userId: user.uid,
        collectionPath: "test_users",
      );

      if (userData == null) return;

      final loggedInUser = UserModel.fromMap(userData);
      userService.currentUser.value = loggedInUser;

      Get.offAllNamed(AppRoutes.homepage.path);
    } catch (e, stackTrace) {
      debugPrint("Error : $e");
      debugPrint("stackTrace : $stackTrace");
    } finally {
      AppLoadings.hideOverlayLoading();
    }
  }
}
