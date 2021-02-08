import "package:flutter/material.dart";
import "package:home_automation/components/lights_widget/lights_widget.dart";
import 'package:home_automation/components/switches_widget/switches_widget.dart';

class WidgetInfo {
  WidgetInfo({this.name, this.description, this.icon, this.id});

  final String name;
  final String description;
  final Icon icon;
  final String id;
}

List<WidgetInfo> widgets = [
  WidgetInfo(
    name: "Lights",
    description: "Track and control one or more light bulbs",
    icon: Icon(Icons.lightbulb_outline, color: Colors.orange),
    id: "lights",
  ),
  WidgetInfo(
    name: "Switch",
    description: "Control various switches",
    icon: Icon(Icons.swap_horiz, color: Colors.green),
    id: "switch",
  ),
];

final _widgetsMap = {
  "lights": () => LightsWidget(),
  "switch": () => SwitchesWidget(),
};

Widget getAutomationWidgetById(String id) {
  return _widgetsMap[id]();
}
