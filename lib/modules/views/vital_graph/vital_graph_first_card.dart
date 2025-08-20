import 'package:flutter/material.dart';
import 'package:ntt_data/modules/views/vital_graph/helper/vital_grapgh_helper.dart';
import 'package:ntt_data/widgets/bar/graph_tab_bar_widget.dart';

// ignore: must_be_immutable
class VitalGraphFirstCard extends StatelessWidget {
  VitalGraphFirstCard({super.key});
  List<Widget> tabWidget = [];
  var vitalHelper = VitalGraphHelper();
  @override
  Widget build(BuildContext context) {
    tabWidget = <Widget>[
      _buildWidget(
        VitalGraphHelper.tabWellnessWidgets,
        VitalGraphHelper.tabBarWellnessWidget,
      ),
      _buildWidget(
        VitalGraphHelper.tabVitalSignWidgets,
        VitalGraphHelper.tabBarVitalSignWidget,
      ),
      _buildWidget(
        VitalGraphHelper.tabBBTWidgets,
        VitalGraphHelper.tabBarBloodlessWidget,
      ),
      _buildWidget(
        VitalGraphHelper.tabRiskWidgets,
        VitalGraphHelper.tabBarRiskWidget,
      ),
      _buildWidget(
        VitalGraphHelper.tabStressWidgets,
        VitalGraphHelper.tabBarStressWidget,
      ),
      _buildWidget(
        VitalGraphHelper.tabHRBWidgets,
        VitalGraphHelper.tabBarHRVWidgets,
      ),
      _buildWidget(
        VitalGraphHelper.tabAHRVWidgets,
        VitalGraphHelper.tabBaHRVWidget,
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
