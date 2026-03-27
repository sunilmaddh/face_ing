import 'package:ntt_data/modules/auth/models/requests/medical_question_answer_request.dart';
import 'package:ntt_data/modules/auth/models/requests/per_details_doa_request.dart';
import 'package:ntt_data/modules/auth/models/requests/user_doa_request.dart';

class ProfileCreationRequest {
  final UserDaoRequest userDao;
  final PerDetailsDaoRequest perDetailsDao;
  final List<MedicalQuestionAnswerRequest> helthDetailsListDao;

  const ProfileCreationRequest({
    required this.userDao,
    required this.perDetailsDao,
    required this.helthDetailsListDao,
  });

  Map<String, dynamic> toJson() {
    return {
      "userDao": userDao.toJson(),
      "perDetailsDao": perDetailsDao.toJson(),
      "helthDetailsListDao":
          helthDetailsListDao.map((e) => e.toJson()).toList(),
    };
  }
}
