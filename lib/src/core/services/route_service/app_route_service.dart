import 'package:get/get.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/view/login_view.dart';
import 'package:stackbuffer_test/src/modules/authentication/splash/view/splash_view.dart';
import 'package:stackbuffer_test/src/modules/home/homepage/views/homepage_view.dart';
import 'package:stackbuffer_test/src/modules/product_details/views/product_details_view.dart';

enum AppRoutes {
  initial,
  login,
  homepage,
  productDetails,
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.initial.path, page: () => SplashView()),
    GetPage(name: AppRoutes.login.path, page: () => LoginView()),
    GetPage(name: AppRoutes.homepage.path, page: () => HomepageView()),
    GetPage(
        name: AppRoutes.productDetails.path, page: () => ProductDetailsView()),
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
      case AppRoutes.productDetails:
        return '/productDetails';
      // Default route
    }
  }
}
