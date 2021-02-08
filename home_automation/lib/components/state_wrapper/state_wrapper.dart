import 'package:flutter/foundation.dart';

class StateWrapper {
  StateWrapper({this.state});

  final dynamic state;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateWrapper &&
          runtimeType == other.runtimeType &&
          mapEquals(state, other.state);

  @override
  int get hashCode => state.hashCode;
}
