class ApiEndpoints {
  static final ApiEndpoints _instance = ApiEndpoints._internal();

  factory ApiEndpoints() {
    return _instance;
  }

  ApiEndpoints._internal();

  static const String baseUrl="192.168.1.234:8085";

  static const String login='/login',
  signUp="/signup",
  verifySignUpOtp='/verifySignupOtp',
  continueSignUp='/continueSineup',
  getforgetOtp='/forgotPassword',
  verifyForgotOtp='/signupOtp',
  resetPassword='/resetPassword';



}