import 'package:get/get.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/view/login_view.dart';
import 'package:stackbuffer_test/src/modules/authentication/splash/view/splash_view.dart';
import 'package:stackbuffer_test/src/modules/home/homepage/views/homepage_view.dart';

import '../../../modules/food_details_view/views/food_details_view.dart';

enum AppRoutes { initial, login, homepage, foodDetailsScreen }

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.initial.path, page: () => SplashView()),
    GetPage(name: AppRoutes.login.path, page: () => LoginView()),
    GetPage(name: AppRoutes.homepage.path, page: () => HomepageView()),
    GetPage(
      name: AppRoutes.foodDetailsScreen.path,

      page: () {
        final args = Get.arguments;
        return FoodDetailsScreen(tag: args['tag']);
      },
    ),
  ];
}

extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.initial:
        return '/';
      case AppRoutes.login:
        return '/login';
      case AppRoutes.homepage:
        return '/homepage';
      case AppRoutes.foodDetailsScreen:
        return '/foodDetailsScreen';
      // Default route
    }
  }
}
