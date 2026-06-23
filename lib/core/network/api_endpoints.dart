class ApiEndpoints {
  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints() {
    return _instance;
  }

  ApiEndpoints._internal();

  static const String voiceBaseUrl = "dev.sourcebytes.ai";
  String initiateWebhook = "/api/v1/voice_agent/web/voice/webhook";
  static const String initiateWebsocket =
      "wss://dev.sourcebytes.ai/ws/v1/web/voice_agent";

  static const String sessionUrl =
      "http://${ApiEndpoints.baseUrl}/kintsugi/submit-audio";

  static const String baseUrl =
      //"192.168.0.120:8085";
      //dev
      "146.190.11.132:8085";
  //Stagging singapore
  // "18.141.189.197:8085";
  //stagging
  // "165.22.208.159:8085";
  // "64.227.165.247:8085";
  //local
  // "192.168.0.121:8085";
  String login = '/login',
      signUp = "/signup",
      verifySignUpOtp = '/verifySignupOtp',
      continueSignUp = '/continueSignup',
      getforgetOtp = '/forgotPassword',
      verifyForgotOtp = '/verifyForGetPasOtp',
      medicalQuestionList = '/sendAllOnboardingQuestions',
      resetPassword = '/resetPassword',
      geustHistoryList = "/perGuestHistory",
      addGeust = "/addGuest",
      listOfGeust = "/listOfGuest",
      searchGeust = "/searchGuest",
      deleteGuest = "/removeGuest",
      userHealthHistory = "/userHealthHistory",
      userHealthDetails = "/perHealthHistory",
      storeSdkDataForUser = "/userSDKData",
      profileUpload = '/editProfile',
      updatePersonalDetails = '/updatePersonalDetails',
      getVitalDescryption = "/getVitalDescryption",
      logoutUser = "/logoutUser",
      graphData = "/graphData",
      scanProgressMessage = "/scanMessage",
      getLatestScore = "/getLatestScore",
      getPulseSurveyQuestionsForUser = "/getPulseSurveyQuestionsForUser",
      saveUserPulseSurvey = "/saveUserPulseSurvey",
      pulseSurveyHome = "/pulseSurveyHome",
      voiceAgent = "/voiceAgent",
      kintsugiInitiate = "/kintsugi/initiate",
      kintsugiQuestionnaires = "/kintsugi/questionnaires",
      kintsugiSessions = "/kintsugi/sessions",
      kintsugiResult = "/kintsugi/result",
      refreshToken = '/getTokenByRefreshToken';
}
