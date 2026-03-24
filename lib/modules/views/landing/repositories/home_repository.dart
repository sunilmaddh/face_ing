import 'package:ntt_data/core/network/api_response.dart';
import 'package:ntt_data/data/models/latest_wellness_model.dart';
import 'package:ntt_data/modules/views/landing/service/home_service.dart';

class HomeRepository {
  HomeRepository({required this.homeService});
  final HomeService homeService;
  Future<ApiResponse<LatestWellnessModel>> getLetestscore() async {
    return await homeService.getLatestWellnessScore();
  }
}
