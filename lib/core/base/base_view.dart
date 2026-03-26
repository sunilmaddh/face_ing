import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/routes/app_navigation.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  Widget buildView(BuildContext context, T controller);

  void onInit(T controller) {}
  void onReady(T controller) {}
  void onDispose(T controller) {}

  bool get useDefaultLoader => true;
  Color get loaderBarrierColor => Colors.black26;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late final T controller;

  Worker? _errorWorker;
  Worker? _successWorker;
  Worker? _navigationWorker;
  Worker? _dialogWorker;
  Worker? _bottomSheetWorker;
  Worker? _retryWorker;

  @override
  void initState() {
    super.initState();

    controller = Get.find<T>();

    widget.onInit(controller);

    _errorWorker = ever(controller.errorMessage, (msg) {
      if (msg != null && msg.toString().isNotEmpty) {
        AppSnackbar.show(
          title: "Error",
          message: msg.toString(),
          isError: true,
        );
        controller.clearError();
      }
    });

    _successWorker = ever(controller.successMessage, (msg) {
      if (msg != null && msg.toString().isNotEmpty) {
        AppSnackbar.show(title: "Success", message: msg.toString());
        controller.clearSuccess();
      }
    });

    _navigationWorker = ever(controller.navigationEvent, (event) {
      if (event == null) return;

      switch (event.type) {
        case NavigationType.to:
          if (event.route != null) {
            AppNavigation.to(event.route!, arguments: event.arguments);
          }
          break;

        case NavigationType.off:
          if (event.route != null) {
            AppNavigation.off(event.route!, arguments: event.arguments);
          }
          break;

        case NavigationType.offAll:
          if (event.route != null) {
            AppNavigation.offAll(event.route!, arguments: event.arguments);
          }
          break;
        case NavigationType.back:
          Get.back(result: event.result);
          break;
      }

      controller.clearNavigation();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onReady(controller);
    });
  }

  @override
  void dispose() {
    widget.onDispose(controller);

    _errorWorker?.dispose();
    _successWorker?.dispose();
    _navigationWorker?.dispose();
    _dialogWorker?.dispose();
    _bottomSheetWorker?.dispose();
    _retryWorker?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.useDefaultLoader) {
      return widget.buildView(context, controller);
    }

    return Stack(
      children: [
        widget.buildView(context, controller),
        Obx(() {
          if (!controller.isLoading.value) {
            return const SizedBox.shrink();
          }

          return Positioned.fill(
            child: Container(
              color: widget.loaderBarrierColor,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }),
      ],
    );
  }
}
