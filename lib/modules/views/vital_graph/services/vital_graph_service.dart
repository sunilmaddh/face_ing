import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';

class VitalGraphService {
  VitalGraphService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<VitalGraphResponseModel>> callVitalGraphApiServices({
    required var data,
  }) async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.graphData,
        method: HttpMethod.post,
        body: data,
      ),
      fromJson: (json) => VitalGraphResponseModel.fromJson(json),
    );
  }
}
