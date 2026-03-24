import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/guest_list_response_model.dart';
import 'package:ntt_data/data/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/data/models/user_history_list_model.dart';
import 'package:ntt_data/modules/views/geust/services/guest_service.dart';

class GuestRepository {
  GuestRepository({required this.guestService});
  final GuestService guestService;
  Future<ApiResponse<GuestListResponseModel>> getGeustHistory({
    required var data,
  }) async {
    return await guestService.getGeustHistoryService(data: data);
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getGeustDetails({
    required var data,
  }) async {
    return await guestService.getGeustDetailsService(data: data);
  }

  Future<ApiResponse<void>> addGeust({required var data}) async {
    return await guestService.addGeustService(data: data);
  }

  Future<ApiResponse<void>> deleteGuest({required var data}) async {
    return await guestService.deleteGuest(data: data);
  }

  Future<ApiResponse<void>> storeBinahHealthForUser({required var data}) async {
    return await guestService.storeBinahHealthForUserService(data: data);
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistory({
    required var data,
  }) async {
    return await guestService.getUserHealthHistoryService(data: data);
  }
}
