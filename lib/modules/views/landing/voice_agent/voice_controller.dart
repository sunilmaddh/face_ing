// import 'package:get/get.dart';
// import 'package:ntt_data/core/utils/app_snackbar.dart';
// import 'package:ntt_data/data/models/kintsugi_initiate_response.dart';
// import 'package:ntt_data/data/services/voice_service.dart';
// import 'package:ntt_data/modules/views/landing/voice_agent/repositories/voice_agent_repository.dart';

// class VoiceController extends GetxController {
//   VoiceController({required this.voiceAgentRepository});
//   final VoiceAgentRepository voiceAgentRepository;
//   RxBool isStarted = false.obs;
//   RxBool isInitiating = false.obs;

//   Future<String> initiateKintisugi() async {
//     var responseData = await voiceAgentRepository.initiateKintsugiApi();

//     if (responseData.statusCode == 200) {
//       var result = responseData.data;
//       return result!.sessionId!;
//     } else {
//       AppSnackbar.show(
//         title: "Error",
//         message: "Something went wrong",
//         isError: true,
//       );
//       return "";
//     }
//   }

//   // Future<void> questionaryKintisugi() async {
//   //   Map<String, dynamic> responseData =
//   //       await voiceAgentRepository.questionaryKintsugiApi();
//   //   int statusCode = responseData["statusCode"];
//   //   if (statusCode == 200) {
//   //   } else {
//   //     AppSnackbar.show(
//   //       title: "Error",
//   //       message: "Something went wrong",
//   //       isError: true,
//   //     );
//   //   }
//   // }
// }
