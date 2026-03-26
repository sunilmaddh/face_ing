import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/services/vital_graph_service.dart';

class VitalGraphRepository {
  VitalGraphRepository({required this.vitalGraphService});
  final VitalGraphService vitalGraphService;
  Future<ApiResponse<VitalGraphResponseModel>> getVitalGraphData({
    required var data,
  }) async {
    return await vitalGraphService.callVitalGraphApiServices(data: data);
  }
}
