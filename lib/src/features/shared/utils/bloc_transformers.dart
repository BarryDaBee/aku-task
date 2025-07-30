import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocTransformers {

  const BlocTransformers._();
  /// A transformer that debounces events by [duration].
  ///
  /// Useful for things like search—waits for the user to stop typing
  /// before firing the latest event. If a new event comes in before
  /// [duration] ends, it cancels the previous one and restarts.
  ///
  /// Delays rapid-fire events like keystrokes; only processes the latest one
  /// after a short pause.
  ///
  static EventTransformer<T> debounceRestartable<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  /// A transformer that drops new events while a previous one is running.
  ///
  /// Useful for preventing overlapping calls—like repeated button taps
  /// or requests triggered too quickly in succession.
  ///
  /// Ignores any incoming events until the current one completes,
  /// ensuring only one event is processed at a time.
  ///
  static EventTransformer<T> droppable<T>() {
    return (events, mapper) => droppable<T>().call(events, mapper);
  }
}
