import 'package:flutter/material.dart';

import 'get_automation_widget.dart';

class AutomationWidget extends StatelessWidget {
  AutomationWidget({Key key, this.widgetInfo}) : super(key: key);

  final WidgetInfo widgetInfo;

  @override
  Widget build(BuildContext context) {
    final String name = widgetInfo.name;
    final String description = widgetInfo.description;
    final Icon icon = widgetInfo.icon;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: icon,
          title: Text(name),
          subtitle: Text(description),
        ),
        getAutomationWidgetById(widgetInfo.id),
      ],
    );
  }
}
