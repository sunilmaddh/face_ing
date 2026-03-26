import 'package:get/get.dart';

enum NavigationType { to, off, offAll, back }

class NavigationEvent {
  final String? route;
  final dynamic arguments;
  final NavigationType type;
  final dynamic result;

  const NavigationEvent({
    this.route,
    this.arguments,
    required this.type,
    this.result,
  });
}

class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final successMessage = RxnString();
  final navigationEvent = Rxn<NavigationEvent>();

  void showLoading([bool value = true]) => isLoading.value = value;

  void setError(String message) => errorMessage.value = message;
  void clearError() => errorMessage.value = null;

  void setSuccess(String message) => successMessage.value = message;
  void clearSuccess() => successMessage.value = null;

  void navigateTo(String route, {dynamic arguments}) {
    navigationEvent.value = NavigationEvent(
      route: route,
      arguments: arguments,
      type: NavigationType.to,
    );
  }

  void navigateOff(String route, {dynamic arguments}) {
    navigationEvent.value = NavigationEvent(
      route: route,
      arguments: arguments,
      type: NavigationType.off,
    );
  }

  void navigateOffAll(String route, {dynamic arguments}) {
    navigationEvent.value = NavigationEvent(
      route: route,
      arguments: arguments,
      type: NavigationType.offAll,
    );
  }

  void navigateBack({dynamic result}) {
    navigationEvent.value = NavigationEvent(
      type: NavigationType.back,
      result: result,
    );
  }

  void clearNavigation() => navigationEvent.value = null;
}
