abstract class ApplicationEvent extends Object {
  dynamic? _type;

  dynamic get type {
    return _type;
  }

  late dynamic _initiator;
  dynamic get initiator => _initiator;

  /// Provides a common interface by which other application based events can extend from.
  ///
  /// Garbage collection warning!!
  /// Implementors/children fo this class must be wary of adding these event to a NON Broadcast event
  /// stream and these event objects should not be stored.  Their reference to their initiator may
  /// impact proper garbage collection if not disposed of themselves.
  ///
  /// 'type' is meant to be an enumerator which acts as a sub-classification from the event class itself
  /// 'initiator' is a reference to the object that created the event and added the event to the stream
  ///

  ApplicationEvent(dynamic initiator, {dynamic? type}) {
    _type = type;
    _initiator = initiator;
  }
  @override
  String toString() =>
      '[$runtimeType.$type $hashCode] - initiator:${initiator.runtimeType} -  ${initiator.hashCode}';
}
