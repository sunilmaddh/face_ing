import 'package:get/get.dart';
import 'package:ntt_data/controllers.dart/profile_controller.dart';
import 'package:ntt_data/data/repository/api_services.dart';
import 'package:ntt_data/modules/views/auth/auth_controller.dart';

class AppBindings extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut<ApiServices>(()=>ApiServices(),fenix: true);
     Get.lazyPut<AuthController>(()=>AuthController(),fenix: true);
      Get.lazyPut<ProfileController>(()=>ProfileController(),fenix: true);
  }}