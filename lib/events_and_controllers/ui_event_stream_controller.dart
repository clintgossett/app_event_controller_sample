import 'app_stream_controller.dart';
import 'application_event.dart';

class UIEventStreamController extends AppStreamController<UIEvent> {}

class UIEvent extends ApplicationEvent {
  dynamic? _data;
  dynamic get data => _data;

  UIEvent(dynamic type, dynamic initiator, {dynamic data})
      : super(initiator, type: type) {
    _data = data;
  }

  @override
  String toString() {
    return super.toString() +
        ' data: [${data?.runtimeType} hash: ${data?.runtimeType}';
  }
}

enum UIEventType { proposals_filter_toggle_click }
