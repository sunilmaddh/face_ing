import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntt_data/core/base/base_controller.dart';
import 'package:ntt_data/core/constants/app_constents.dart';
import 'package:ntt_data/core/utils/dialog/common_date_picker.dart';
import 'package:ntt_data/modules/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/modules/vital_graph/models/vital_graph_response_model.dart';
import 'package:ntt_data/modules/vital_graph/repositories/vital_graph_repository.dart';

class VitalGraphController extends BaseController {
  VitalGraphController({required this.vitalGraphRepository});

  final VitalGraphRepository vitalGraphRepository;

  final RxBool isFilterTypeSelected = false.obs;
  final RxInt selectedIndex = 0.obs;

  final Rx<VitalGraphResponseModel> vitalGraphResponse =
      VitalGraphResponseModel().obs;
  final Rx<VitalGraphResponseModel> vitalCalendarResponse =
      VitalGraphResponseModel().obs;

  final Rx<AdvancedHeartRateVariability> wellnessCalendarResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> wellnessGraphResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> vitalSignResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> bloodlessResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> risksResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> stressResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> hrvResponse =
      AdvancedHeartRateVariability().obs;
  final Rx<AdvancedHeartRateVariability> ahrvResponse =
      AdvancedHeartRateVariability().obs;

  final RxMap<DateTime, List<EventDot>> eventMap =
      <DateTime, List<EventDot>>{}.obs;

  final Rx<DateTime> calendarDate = DateTime.now().obs;
  final RxString selectedValue = "Weekly".obs;
  final RxInt touchedIndex = (-1).obs;
  final RxBool isTouched = false.obs;
  final RxDouble fontSize = 0.0.obs;
  final RxDouble radius = 0.0.obs;
  final RxString selectedDate = "".obs;
  final RxString selectedMonthDate = "".obs;
  final RxString monthIndex = "".obs;
  final RxString yearIndex = "".obs;
  final RxString monthYearDate = "".obs;
  final RxString isGraphFilterType = "".obs;
  RxInt selectedYear = RxInt(DateTime.now().year);
  final RxInt selectedMonthIndex = RxInt(DateTime.now().month - 1);

  void onMonthChangeInCalendar(DateTime date, StateSetter updateState) {
    calendarDate.value = date;
    final calDate = DateFormat('yyyy/MM').format(calendarDate.value);

    VitalGraphHelper().callForCalenderWithDateRange("4W", calDate, updateState);
  }

  Future<void> callVitalGraphDataApi({
    required Map<String, dynamic> data,
    required bool isFromHistory,
  }) async {
    showLoading(true);

    try {
      debugPrint(data.toString());

      final responseData = await vitalGraphRepository.getVitalGraphData(
        data: data,
      );

      if (responseData.statusCode == 200) {
        await clearData();

        final result = responseData.data;
        if (result == null) {
          setError(AppConstents.commonErrorMessage);
          return;
        }

        vitalGraphResponse.value = result;
        wellnessGraphResponse.value =
            result.wellness ?? AdvancedHeartRateVariability();
        vitalSignResponse.value =
            result.vitalSigns ?? AdvancedHeartRateVariability();
        bloodlessResponse.value =
            result.bloodlessBloodTests ?? AdvancedHeartRateVariability();
        risksResponse.value = result.risks ?? AdvancedHeartRateVariability();
        stressResponse.value = result.stress ?? AdvancedHeartRateVariability();
        hrvResponse.value = result.hrvSddnn ?? AdvancedHeartRateVariability();
        ahrvResponse.value =
            result.advancedHeartRateVariability ??
            AdvancedHeartRateVariability();

        final hrvDetails = hrvResponse.value.vitalTypeDetails;
        if (hrvDetails != null && hrvDetails.isNotEmpty) {
          hrvDetails.first.yValues?.clear();
          hrvDetails.first.yValues?.addAll(["0.0", "75.0", "150.0"]);
        }
      } else {
        await clearData();
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      await clearData();
      debugPrint(e.toString());
      setError(AppConstents.commonErrorMessage);
    } finally {
      showLoading(false);
    }
  }

  Future<void> calendarGraphDataApi({
    required Map<String, dynamic> data,
    StateSetter? updateState,
  }) async {
    try {
      debugPrint(data.toString());

      final responseData = await vitalGraphRepository.getVitalGraphData(
        data: data,
      );

      if (responseData.statusCode == 200) {
        final result = responseData.data;
        if (result == null) return;

        vitalCalendarResponse.value = result;

        final newMap = buildEventMap(
          vitalCalendarResponse
              .value
              .wellness
              ?.vitalTypeDetails
              ?.first
              .healthList,
        );

        eventMap.clear();
        eventMap.addAll(newMap);
        eventMap.refresh();

        if (updateState != null) {
          updateState(() {});
        }
      } else {
        setError(AppConstents.commonErrorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
      setError(AppConstents.commonErrorMessage);
    }
  }

  Map<DateTime, List<EventDot>> buildEventMap(List<HealthList>? events) {
    if (events == null || events.isEmpty) return {};

    final Map<DateTime, List<EventDot>> mappedEvents = {};

    for (final item in events) {
      if (item.scannedDate == null) continue;

      final date = DateTime.parse(item.scannedDate!);
      final key = DateTime(date.year, date.month, date.day);

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
          break;
        default:
          dotColor = Colors.white;
      }

      mappedEvents.putIfAbsent(key, () => []);
      mappedEvents[key]!.add(EventDot(dotColor));
    }

    return mappedEvents;
  }

  Future<void> clearData() async {
    vitalGraphResponse.value = VitalGraphResponseModel();
    vitalSignResponse.value = AdvancedHeartRateVariability();
    bloodlessResponse.value = AdvancedHeartRateVariability();
    stressResponse.value = AdvancedHeartRateVariability();
    risksResponse.value = AdvancedHeartRateVariability();
    hrvResponse.value = AdvancedHeartRateVariability();
    ahrvResponse.value = AdvancedHeartRateVariability();
    wellnessGraphResponse.value = AdvancedHeartRateVariability();
  }

  String formatToYearMonthFromString(String dateString) {
    final normalized = dateString.replaceAll('/', '-');
    final date = DateFormat('yyyy-MM-dd').parse(normalized);
    return DateFormat('yyyy-MMM').format(date);
  }
}
