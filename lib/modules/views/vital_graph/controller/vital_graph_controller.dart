import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/utils/app_snackbar.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:ntt_data/data/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/views/vital_graph/repositories/vital_graph_repository.dart';

class VitalGraphController extends GetxController {
  VitalGraphController({required this.vitalGraphRepository});
  final VitalGraphRepository vitalGraphRepository;
  RxBool isFilterTypeSelected = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  Rx<VitalGraphResponseModel> vitalGraphResponse =
      VitalGraphResponseModel().obs;
  Rx<VitalGraphResponseModel> vitalCalenderResponse =
      VitalGraphResponseModel().obs;
  Rx<AdvancedHeartRateVariability> wellnessCalenderResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> wellnessGraphResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> vitalSignesponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> bloodlessResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> risksResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> stressResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> hrvResponse =
      AdvancedHeartRateVariability().obs;
  Rx<AdvancedHeartRateVariability> ahrvResponse =
      AdvancedHeartRateVariability().obs;
  // var services = VitalGraphServices();

  final RxMap<DateTime, List<EventDot>> eventMap =
      <DateTime, List<EventDot>>{}.obs;

  Rx<DateTime> calenderDate = DateTime.now().obs;
  RxString selectedValue = "Weekly".obs;
  RxInt touchedIndex = (-1).obs;
  RxBool isTouched = false.obs;
  RxDouble fontSize = 0.0.obs;
  RxDouble radius = 0.0.obs;
  RxString selectedDate = "".obs;
  RxString selectedMonthDate = "".obs;
  RxString monthIndex = "".obs;
  RxString yearIndex = "".obs;
  RxString monthYearDate = "".obs;
  RxString isGraphFilterType = "".obs;
  RxInt selectedYear = RxInt(DateTime.now().year);
  RxInt selectedMonthIndex = RxInt(DateTime.now().month - 1);

  onMonthChangeInCalender(DateTime date, StateSetter updateState) {
    calenderDate.value = date;

    String calDate = '';
    calDate = DateFormat('yyyy/MM').format(calenderDate.value);

    VitalGraphHelper().callForCalenderWithDateRange("4W", calDate, updateState);
  }

  Future<void> callVitalGraphDataApi({
    required Map<String, dynamic> data,
    required bool isFromHistory,
  }) async {
    isLoading(true);

    debugPrint(data.toString());
    var responseData = await vitalGraphRepository.getVitalGraphData(data: data);

    isLoading(false);
    try {
      if (responseData.statusCode == 200) {
        await clearData();
        var result = responseData.data;
        vitalGraphResponse.value = result!;
        wellnessGraphResponse.value = vitalGraphResponse.value.wellness!;
        vitalSignesponse.value = vitalGraphResponse.value.vitalSigns!;
        bloodlessResponse.value = vitalGraphResponse.value.bloodlessBloodTests!;
        risksResponse.value = vitalGraphResponse.value.risks!;
        stressResponse.value = vitalGraphResponse.value.stress!;
        hrvResponse.value = vitalGraphResponse.value.hrvSddnn!;
        ahrvResponse.value =
            vitalGraphResponse.value.advancedHeartRateVariability!;
        hrvResponse.value.vitalTypeDetails!.first.yValues!.clear();

        List<String> li = ["0.0", "75.0", "150.0"];
        hrvResponse.value.vitalTypeDetails!.first.yValues!.addAll(li);
        if (isFromHistory) {
          isFromHistory = false;
        }
      } else if (responseData.statusCode == 403) {
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: false,
        );
      } else {
        await clearData();
        AppSnackbar.show(
          title: "Error",
          message: "Something went wrong",
          isError: false,
        );
      }
    } catch (e) {
      isLoading(false);
      // AppSnackbar.show(title: "Error", message: e.toString(), isError: false);
    }
  }

  Future<void> callenderGraphDataApi({
    required Map<String, dynamic> data,
    StateSetter? updateState,
  }) async {
    // isLoading(true);

    debugPrint(data.toString());
    var responseData = await vitalGraphRepository.getVitalGraphData(data: data);

    // isLoading(false);
    try {
      if (responseData.statusCode == 200) {
        var result = responseData.data;
        vitalCalenderResponse.value = result!;

        Map<DateTime, List<EventDot>> newMap = buildEventMap(
          vitalCalenderResponse
              .value
              .wellness
              ?.vitalTypeDetails
              ?.first
              .healthList,
        );

        newMap.forEach((date, dots) {
          eventMap[date] = dots;
        });

        eventMap.refresh();
        if (updateState != null) {
          updateState(() {});
        }
      }
    } catch (e) {
      // isLoading(false);
      // AppSnackbar.show(title: "Error", message: e.toString(), isError: false);
    }
  }

  Map<DateTime, List<EventDot>> buildEventMap(List<HealthList>? events) {
    if (events == null || events.isEmpty) return {};
    Map<DateTime, List<EventDot>> eventMap = {};

    for (HealthList item in events) {
      DateTime date = DateTime.parse(item.scannedDate!);

      DateTime key = DateTime(date.year, date.month, date.day);

      Color dotColor;
      switch (item.status) {
        case "High":
          dotColor = Colors.green;
          break;
        case "Low":
          dotColor = Colors.red;
          break;
        case "Medium":
          dotColor = Colors.amber;
        default:
          dotColor = Colors.white; // Normal
      }

      if (eventMap[key] == null) {
        eventMap[key] = [EventDot(dotColor)];
      } else {
        eventMap[key]!.add(EventDot(dotColor));
      }
    }
    return eventMap;
  }

  Future<void> clearData() async {
    vitalGraphResponse.value = VitalGraphResponseModel();
    vitalSignesponse.value = AdvancedHeartRateVariability();
    bloodlessResponse.value = AdvancedHeartRateVariability();
    stressResponse.value = AdvancedHeartRateVariability();
    risksResponse.value = AdvancedHeartRateVariability();
    hrvResponse.value = AdvancedHeartRateVariability();
    ahrvResponse.value = AdvancedHeartRateVariability();
  }

  String formatToYearMonthFromString(String dateString) {
    String normalized = dateString.replaceAll('/', '-');
    DateTime date = DateFormat('yyyy-MM-dd').parse(normalized);
    return DateFormat('yyyy-MMM').format(date);
  }
}
