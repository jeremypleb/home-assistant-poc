import 'package:flutter/material.dart';
import 'package:home_automation/components/switches_widget/switch_widget.dart';
import 'package:home_automation/components/switches_widget/switches_config.dart';

class SwitchesWidget extends StatelessWidget {
  final Map<String, SwitchWidgetInfo> switchWidgets = {
    'ac': SwitchWidgetInfo(
        name: 'AC',
        icon: Icons.ac_unit,
        activeColor: Colors.blue,
        id: Switches.AC),
    'decorative_lights': SwitchWidgetInfo(
        name: 'Decorative Lights',
        icon: Icons.flash_on,
        activeColor: Colors.yellow,
        id: Switches.DECORATIVE_LIGHTS),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> switchWidgetsList = switchWidgets.values
        .map((lw) => SwitchWidget(switchWidgetInfo: lw))
        .toList();

    return Column(
      children: switchWidgetsList,
    );
  }
}
