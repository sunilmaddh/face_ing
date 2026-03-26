import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/modules/geust/models/guest_list_response_model.dart';
import 'package:ntt_data/modules/profile/models/healthDetailsResponseModel.dart';
import 'package:ntt_data/modules/profile/models/user_history_list_model.dart';
import 'package:ntt_data/modules/geust/services/guest_service.dart';

class GuestRepository {
  GuestRepository({required this.guestService});
  final GuestService guestService;
  Future<ApiResponse<GuestListResponseModel>> getGeustHistory({
    required String userId,
  }) async {
    return await guestService.getGeustHistoryService(userId: userId);
  }

  Future<ApiResponse<HealthDetailsResponseModel>> getGeustDetails({
    required String userId,
    required String guestId,
    required String scanId,
    required bool isFullHistory,
  }) async {
    return await guestService.getGeustDetailsService(
      userId: userId,
      guestId: guestId,
      scanId: scanId,
      isFullHistory: isFullHistory,
    );
  }

  Future<ApiResponse<void>> addGeust({required var data}) async {
    return await guestService.addGeustService(data: data);
  }

  Future<ApiResponse<void>> deleteGuest({
    required String userId,
    required String guestId,
  }) async {
    return await guestService.deleteGuest(userId: userId, guestId: guestId);
  }

  Future<ApiResponse<void>> storeBinahHealthForUser({required var data}) async {
    return await guestService.storeBinahHealthForUserService(data: data);
  }

  Future<ApiResponse<UserHistoryListModel>> getUserHealthHistory({
    required String userId,
    required String isUser,
    required String guestId,
  }) async {
    return await guestService.getUserHealthHistoryService(
      userId: userId,
      isUser: isUser,
      guestId: guestId,
    );
  }
}
