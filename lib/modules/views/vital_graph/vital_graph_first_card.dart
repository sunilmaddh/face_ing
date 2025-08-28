import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntt_data/demo/vital_graph_widget.dart';
import 'package:ntt_data/modules/views/vital_graph/controller/vital_graph_controller.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatelessWidget {
  VitalGraphFirstCard({super.key});
  List<Widget> tabWidget = [];
  var vitalHelper = VitalGraphHelper();
  final _vitalController = Get.find<VitalGraphController>();
  @override
  Widget build(BuildContext context) {
    tabWidget = <Widget>[
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
      _buildWidget(
        _vitalController
            .vitalGraphResponse
            .value
            .advancedHeartRateVariability!
            .vitalType!
            .map((title) => Tab(text: title))
            .toList(),
        List.generate(
          _vitalController
              .vitalGraphResponse
              .value
              .advancedHeartRateVariability!
              .vitalTypeDetails!
              .length,
          (_) =>
              VitalGraphWidget(leftTitle: [], bottomTitles: [], vitalValue: []),
        ),
      ),
    ];
    return SizedBox(
      height: 500,
      child: GraphTabBarWidget(
        isNotRadius: false,
        tabWidgets: VitalGraphHelper.tabGraphWidgets,
        tabBarWidgets: tabWidget,
      ),
    );
  }

  _buildWidget(List<Widget> tabWidget, List<Widget> tabBarWidget) {
    return GraphTabBarWidget(
      tabWidgets: tabWidget,
      tabBarWidgets: tabBarWidget,
      isNotRadius: true,
    );
  }
}
