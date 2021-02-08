import 'package:flutter/material.dart';
import 'package:home_automation/services/home_assistant/home_assistant_socket.dart';
import 'package:provider/provider.dart';
import 'package:home_automation/components/lights_widget/light_widget.dart';

String _formattedDate(String date) {
  DateTime dateTime = DateTime.parse(date);

  return "${dateTime.hour.toString()}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}

class LightWidgetModal extends StatelessWidget {
  LightWidgetModal({Key key, this.lightWidgetInfo}) : super(key: key);

  final LightWidgetInfo lightWidgetInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lightWidgetInfo.name),
      ),
      body: Container(
        child: Selector<HomeAssistantSocket, dynamic>(
            selector: (_, socket) => socket.state[lightWidgetInfo.id],
            builder: (_, data, __) => data != null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("State: ${data['state']}"),
                          Text(
                              "Last Changed: ${_formattedDate(data['last_changed'])}"),
                          Text(
                              "Last Updated: ${_formattedDate(data['last_updated'])}"),
                        ]))
                : Container(
                    width: 0.0,
                    height: 0.0,
                  )),
      ),
    );
  }
}
