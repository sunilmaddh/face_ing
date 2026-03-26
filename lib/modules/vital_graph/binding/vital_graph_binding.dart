import 'package:get/get.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/modules/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/vital_graph/repositories/vital_graph_repository.dart';
import 'package:ntt_data/modules/vital_graph/services/vital_graph_service.dart';

class VitalGraphBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VitalGraphService>(
      () => VitalGraphService(apiService: Get.find<ApiService>()),
    );
    Get.lazyPut<VitalGraphRepository>(
      () => VitalGraphRepository(
        vitalGraphService: Get.find<VitalGraphService>(),
      ),
    );
    Get.lazyPut<VitalGraphController>(
      () => VitalGraphController(
        vitalGraphRepository: Get.find<VitalGraphRepository>(),
      ),
    );
  }
}
