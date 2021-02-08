import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class HomeAssistantSocket extends ChangeNotifier {
  IOWebSocketChannel channel;

  String homeAssistantAddress;
  String accessToken;

  int currentSubId = 0;
  final Map<int, Function> callbackMap = {};

  final Map<String, dynamic> state = {};
  Map<String, dynamic> config = {};
  Map<String, dynamic> services = {};

  bool stateLoaded = false;
  bool configLoaded = false;
  bool servicesLoaded = false;
  bool get isLoaded {
    return stateLoaded && configLoaded && servicesLoaded;
  }

  HomeAssistantSocket(this.homeAssistantAddress, this.accessToken) {
    print(
        'Creating HomeAssistant socket at ws://${this.homeAssistantAddress}/api/websocket');
    this.channel = IOWebSocketChannel.connect(
        'ws://${this.homeAssistantAddress}/api/websocket');
    this.channel.stream.listen(this.onMessage);
  }

  int nextSubId() {
    this.currentSubId += 1;
    return this.currentSubId;
  }

  authenticate() {
    Map<String, String> authMsg = {
      'type': 'auth',
      'access_token': this.accessToken
    };
    this.wbSend(authMsg);
  }

  loadState() {
    void callback(Map<String, dynamic> stateObj) {
      if (stateObj['success']) {
        for (dynamic obj in stateObj['result']) {
          this.state[obj['entity_id']] = obj;
        }
        print("state loaded");
        this.stateLoaded = true;
        notifyListeners();
      }
    }

    this.send({}, "get_states", callback);
  }

  loadConfig() {
    void callback(Map<String, dynamic> confObj) {
      if (confObj['success']) {
        this.config = confObj['result'];
        print("config loaded");
        this.configLoaded = true;
      }
    }

    this.send({}, "get_config", callback);
  }

  loadServices() {
    void callback(Map<String, dynamic> serviceObj) {
      if (serviceObj['success']) {
        this.services = serviceObj['result'];
        print("services loaded");
        this.servicesLoaded = true;
      }
    }

    this.send({}, "get_services", callback);
  }

  void registerCallback(int id, Function callback) {
    this.callbackMap[id] = callback;
  }

  void deregisterCallback(int id) {
    this.callbackMap.remove(id);
  }

  void subscribeToStateChanged() {
    void callback(stateChangedObj) {
      if (stateChangedObj['type'] == 'event') {
        var event = stateChangedObj['event'];
        if (event['event_type'] == 'state_changed') {
          var entityId = event['data']['entity_id'];
          var newState = event['data']['new_state'];

          // Only modify one piece of state at a time
          this.state[entityId] = newState;
        }
      }
      notifyListeners();
    }

    // anytime we get an update, we notify our listeners
    this.send({'event_type': 'state_changed'}, 'subscribe_events', callback,
        respondsOnce: false);
  }

  void onMessage(dynamic messageJson) {
    Map<String, dynamic> message = json.decode(messageJson);
    if (message['type'] == 'auth_required') {
      // web socket authentication, should happen once per session
      this.authenticate();
    } else if (message['type'] == 'auth_ok') {
      // now that we are authenticated load state, config, and services, should happen once per session
      this.loadState();
      this.loadConfig();
      this.loadServices();
      this.subscribeToStateChanged();
    } else if (message.containsKey('id')) {
      // handle events, should happen with every additional event
      var msgId = message['id'];
      this.callbackMap[msgId](message);
    }
  }

  void wbSend(dynamic messageObj) {
    channel.sink.add(json.encode(messageObj));
  }

  void send(Map<String, dynamic> messageObj, String msgType, Function callback,
      {bool respondsOnce: true}) {
    int subscriptionId = this.nextSubId();
    messageObj['id'] = subscriptionId;
    messageObj['type'] = msgType;

    if (callback == null) {
      callback = (dynamic msg) => Null;
    }

    var callbackWrapper = (dynamic msg) {
      if (respondsOnce) {
        this.deregisterCallback(subscriptionId);
      }
      callback(msg);
    };

    this.registerCallback(subscriptionId, callbackWrapper);
    this.wbSend(messageObj);
  }

  callService(domain, service, serviceData) {
    /* Example
    Turn on light:
      callService('light', 'turn_on', {entity_id: 'light.living_room', transition: 3})
    Turn off light:
      callService('light', 'turn_off', {entity_id: 'light.living_room'})
    */
    var messageData = {
      'domain': domain,
      'service': service,
      'service_data': serviceData
    };
    return this.send(messageData, 'call_service', null);
  }
}
