import 'package:flutter/material.dart';

import 'automation_widget.dart';
import 'get_automation_widget.dart';

class AutomationWidgets extends StatelessWidget {
  AutomationWidgets({Key key, this.widgets}) : super(key: key);

  final List<WidgetInfo> widgets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(child: AutomationWidget(widgetInfo: widgets[index]));
        });
  }
}
