import 'package:appx/events_and_controllers/app_stream_controller.dart';
import 'package:appx/events_and_controllers/ui_event_stream_controller.dart';

import 'events_and_controllers/application_event.dart';

void main() {
  /// UI Stream Controller
  var usc = UIEventStreamController();

  /// Event listener will for both UIEvent objects and ancestors.
  usc.on<UIEvent>().listen((event) {
    print("on<UIEvent> Fired' ${event.toString()}");
  });

  usc.on<UIEvent2>().listen((event) {
    print("on<UIEvent2> Fired' ${event.toString()}");
  });

  usc.onTypes({UIEventType.proposals_filter_toggle_click, "hello"}).listen(
      (event) {
    print("onEventTypes() Fired' ${event.toString()}");
  });

  /// Add Events
  usc.add(UIEvent(UIEventType.proposals_filter_toggle_click, {}));
  // Can add and filter for child events of parent event type.
  usc.add(UIEvent2("hello", {}));

  ////  Cannot add event outside of heirarchy.
  // evc.add(NotUIEvent(UIEventType.proposals_filter_toggle_click, {}));

  /// Command Stream Controller
  var csc_async = CommandStreamController();
  var csc_sync = CommandStreamControllerSync();

  //// Command Listeners
  csc_async.on<Command>().listen((command) {
    print("async : on<Command> Fired' ${command.toString()}");
  });

  csc_sync.on<Command>().listen((command) {
    print("sync : on<Command> Fired' ${command.toString()}");
  });

  //// Add Command (fake initiator with object)
  csc_async.add(Command({}));
  csc_async.add(Command({}));
  csc_async.add(Command({}));
  print("interest point 0");

  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  print("interest point 1");
  csc_async.add(Command({}));
  csc_async.add(Command({}));
  print("interest point 2");

  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  csc_sync.add(Command({}));
  print("interest point 3");
  Future.microtask(() => print("myMicrotask()"));
  Future.delayed(Duration.zero, () => print("myDealyed()"));
}

class CommandStreamController extends AppStreamController<Command> {}

class CommandStreamControllerSync extends AppStreamController<Command> {
  CommandStreamControllerSync() : super(sync: true);
}

class Command extends ApplicationEvent {
  Command(initiator) : super(initiator);
}

class NotUIEvent extends ApplicationEvent {
  dynamic? _data;
  dynamic get data => _data;

  NotUIEvent(dynamic type, dynamic initiator, {dynamic data})
      : super(initiator, type: type) {
    _data = data;
  }

  @override
  String toString() {
    return super.toString() +
        ' itemSelected: [${data?.runtimeType} hash: ${data?.runtimeType}';
  }
}

class UIEvent2 extends UIEvent {
  UIEvent2(dynamic type, dynamic initiator) : super(type, initiator);
}
