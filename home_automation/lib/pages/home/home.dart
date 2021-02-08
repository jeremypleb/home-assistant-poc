import 'package:flutter/material.dart';
import 'package:home_automation/components/automation_widgets/get_automation_widget.dart';
import 'package:home_automation/components/provider_root/provider_root.dart';

import '../../components/automation_widgets/automation_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Automation"),
      ),
      body: AutomationWidgets(widgets: widgets),
    );
  }
}
