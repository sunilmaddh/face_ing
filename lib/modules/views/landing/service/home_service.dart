import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/latest_wellness_model.dart';

class HomeService {
  HomeService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<LatestWellnessModel>> getLatestWellnessScore() async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.getLatestScore,
        method: HttpMethod.post,
      ),
      fromJson: (json) => LatestWellnessModel.fromJson(json),
    );
  }
}
