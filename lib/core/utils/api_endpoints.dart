class ApiEndpoints {
  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints() {
    return _instance;
  }

  ApiEndpoints._internal();

  static const String baseUrl = '192.168.0.214:8085';
  // "192.168.1.161:8085";
  // "198.199.123.185:8085";
  //  "192.168.1.234:8085";

  //Uat = "http://198.199.123.185:8085/"
  // "192.168.1.114:8085";
  // "192.168.1.234:8085";

  static const String login = '/login',
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
      profileUpload = '/editProfile';
}
