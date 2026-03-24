import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/binah_scan_progress_message_response.dart';
import 'package:ntt_data/modules/views/binah/service/mesurement_service.dart';

class MesurementRepository {
  MesurementRepository({required this.mesurementService});
  final MesurementService mesurementService;
  Future<ApiResponse<BinahScanProgressMessageResponse>>
  getMesurementProgressMessage() async {
    return await mesurementService.getMesurementProgressMessage();
  }
}
