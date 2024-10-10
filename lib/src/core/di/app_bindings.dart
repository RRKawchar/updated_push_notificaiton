import 'package:get/get.dart';
import 'package:push_notification_check/src/features/home/controller/home_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}

