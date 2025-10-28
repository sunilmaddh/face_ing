class ApiEndpoints {
  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints() {
    return _instance;
  }

  ApiEndpoints._internal();

  static const String baseUrl =
      // "146.190.11.132";
      //dev
      "146.190.11.132:8085";
  // '192.168.0.214:8085';
  //Stagging singapore
  //"18.141.189.197:8085";
  //stagging
  //    "64.227.165.247:8085";
  // "192.168.1.161:8085";
  //"198.199.123.185:8085";
  //  "192.168.1.234:8085";

  //Uat = "http://198.199.123.185:8085/"
  // "192.168.1.114:8085";
  // "192.168.1.234:8085";

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
      refreshToken = '/getTokenByRefreshToken';
}
