import 'package:ntt_data/core/network/api_request.dart';
import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/core/network/api_service.dart';
import 'package:ntt_data/core/utils/api_endpoints.dart';
import 'package:ntt_data/data/models/binah_scan_progress_message_response.dart';

class MesurementService {
  MesurementService({required this.apiService});
  final ApiService apiService;
  final apiEndpoints = ApiEndpoints();
  Future<ApiResponse<BinahScanProgressMessageResponse>>
  getMesurementProgressMessage() async {
    return await apiService.send(
      ApiRequest(
        endpoint: apiEndpoints.scanProgressMessage,
        method: HttpMethod.post,
      ),
    );
  }
}
