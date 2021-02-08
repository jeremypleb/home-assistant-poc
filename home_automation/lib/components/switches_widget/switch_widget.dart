import 'package:flutter/material.dart';
import 'package:home_automation/services/home_assistant/home_assistant_socket.dart';
import 'package:provider/provider.dart';

class SwitchWidgetInfo {
  SwitchWidgetInfo({Key key, this.icon, this.name, this.activeColor, this.id});

  IconData icon;
  String name;
  Color activeColor;
  String id;
}

class SwitchWidget extends StatelessWidget {
  SwitchWidget({Key key, this.switchWidgetInfo}) : super(key: key);

  final SwitchWidgetInfo switchWidgetInfo;

  @override
  Widget build(BuildContext context) {
    HomeAssistantSocket _socket =
        Provider.of<HomeAssistantSocket>(context, listen: false);

    return Selector<HomeAssistantSocket, dynamic>(
      selector: (_, socket) => socket.state[switchWidgetInfo.id],
      builder: (_, data, __) => data != null
          ? SwitchListTile(
              title: Container(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(switchWidgetInfo.name),
                ),
              ),
              secondary: Icon(
                switchWidgetInfo.icon,
                color:
                    data["state"] == "on" ? switchWidgetInfo.activeColor : null,
              ),
              value: data["state"] == "on" ? true : false,
              onChanged: (bool value) {
                print('${switchWidgetInfo.id}, $value');
                _socket.callService('switch', value ? 'turn_on' : 'turn_off',
                    {'entity_id': switchWidgetInfo.id});
              })
          : Container(
              width: 0.0,
              height: 0.0,
            ),
    );
  }
}
