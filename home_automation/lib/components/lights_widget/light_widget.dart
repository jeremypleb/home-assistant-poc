import 'package:flutter/material.dart';
import 'package:home_automation/services/home_assistant/home_assistant_socket.dart';
import 'package:provider/provider.dart';

import 'light_widget_modal.dart';

class LightWidgetInfo {
  LightWidgetInfo({Key key, this.name, this.id});

  String name;
  String id;
}

class LightWidget extends StatelessWidget {
  LightWidget({Key key, this.lightWidgetInfo}) : super(key: key);

  final LightWidgetInfo lightWidgetInfo;

  @override
  Widget build(BuildContext context) {
    HomeAssistantSocket _socket =
        Provider.of<HomeAssistantSocket>(context, listen: false);

    return Selector<HomeAssistantSocket, dynamic>(
      selector: (_, socket) => socket.state[lightWidgetInfo.id],
      builder: (_, data, __) => data != null
          ? SwitchListTile(
              title: InkWell(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LightWidgetModal(
                              lightWidgetInfo: lightWidgetInfo)))
                },
                child: Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(lightWidgetInfo.name),
                  ),
                ),
              ),
              value: data["state"] == "on" ? true : false,
              onChanged: (bool value) {
                print('${lightWidgetInfo.id}, $value');
                _socket.callService('light', value ? 'turn_on' : 'turn_off',
                    {'entity_id': lightWidgetInfo.id});
              })
          : Container(
              width: 0.0,
              height: 0.0,
            ),
    );
  }
}
