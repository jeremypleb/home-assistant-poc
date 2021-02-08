import 'package:flutter/material.dart';
import 'package:home_automation/components/lights_widget/light_widget.dart';
import 'package:home_automation/components/lights_widget/lights_config.dart';

class LightsWidget extends StatelessWidget {
  final Map<String, LightWidgetInfo> lightWidgets = {
    'bed': LightWidgetInfo(name: 'Bed', id: Lights.BED),
    'ceiling': LightWidgetInfo(name: 'Ceiling', id: Lights.CEILING),
    'kitchen': LightWidgetInfo(name: 'Kitchen', id: Lights.KITCHEN),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> lightWidgetsList = lightWidgets.values
        .map((lw) => LightWidget(lightWidgetInfo: lw))
        .toList();

    return Column(
      children: lightWidgetsList,
    );
  }
}
