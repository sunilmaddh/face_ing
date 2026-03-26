import 'package:get/get.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/modules/auth/controllers/auth_controller.dart';
import 'package:ntt_data/modules/auth/repositories/auth_repository.dart';
import 'package:ntt_data/modules/auth/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(
      () => AuthService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(authService: Get.find<AuthService>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find<AuthRepository>()),
    );
  }
}
