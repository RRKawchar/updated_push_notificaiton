import 'package:get/get.dart';
import 'package:push_notification_check/src/features/home/view/pages/home_page.dart';

class AppRoutes {
  static const String homePage = "/home-page";

  static final routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
    )
  ];
}
