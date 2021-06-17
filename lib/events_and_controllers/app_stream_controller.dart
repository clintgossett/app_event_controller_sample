import 'dart:async';

/// Basic Event Stream Singleton which can be
///
/// For info on our composition design pattern, reference:
/// "Mastering Dart, by Sergy Akopkokhyants- Inheritance versus Composition"
abstract class AppStreamController<ApplicationEvent>
    implements StreamController<ApplicationEvent> {
  bool _sync = false;

  late final StreamController<ApplicationEvent> _controller;

  AppStreamController({bool sync = false}) {
    this._sync = sync;
    _controller = StreamController<ApplicationEvent>.broadcast(sync: _sync);
  }

  Stream<ApplicationEvent> on<T>() {
    return stream.where((event) => event is T);
  }

  Stream<ApplicationEvent> onTypes(Set<dynamic> eventTypes) {
    return stream.where((dynamic event) => eventTypes.contains(event.type));
  }

  ////////
  ///
  ///     Public Overrides
  ///
  @override
  set onListen(void Function()? _onListen) {
    _controller.onListen = _onListen;
  }

  @override
  void add(event) {
    _controller.add(event);
  }

  @override
  Stream<ApplicationEvent> get stream => _controller.stream;

  @override
  FutureOr<void> Function()? onCancel;

  @override
  void Function()? onPause;

  @override
  void Function()? onResume;

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<ApplicationEvent> source, {bool? cancelOnError}) {
    // TODO: implement addStream
    throw UnimplementedError();
  }

  @override
  Future close() {
    throw 'The Global Events Stream Is Not to Be Closed.';
  }

  @override
  Future get done => _controller.done;

  @override
  bool get hasListener => _controller.hasListener;

  @override
  bool get isClosed => _controller.isClosed;

  @override
  bool get isPaused => _controller.isPaused;

  @override
  void Function()? get onListen => _controller.onListen;

  @override
  StreamSink<ApplicationEvent> get sink => _controller.sink;
}
