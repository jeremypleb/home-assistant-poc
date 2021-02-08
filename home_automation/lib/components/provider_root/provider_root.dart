import 'package:flutter/material.dart';
import 'package:home_automation/services/home_assistant/home_assistant_config.dart';
import 'package:home_automation/services/home_assistant/home_assistant_socket.dart';
import 'package:provider/provider.dart';

class ProviderRoot extends StatelessWidget {
  ProviderRoot({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    print("In Provider Root");
    return ChangeNotifierProvider(
        create: (_) => HomeAssistantSocket('$ADDRESS:$PORT', TOKEN),
        lazy: false,
        child: child);
  }
}
