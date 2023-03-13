import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_message_stream/flame_message_stream.dart';
import 'package:meta/meta.dart';

/// Mixin allows a component to be notified about an event from game with
/// [HasMessageProviders] mixin.
/// You just need to implement [onStreamMessage] function to process received
/// messages. And implement [streamName] getter to aim the component to specific
/// stream
mixin HasMessageListener<M> on Component {
  String get streamName;

  /// The function is subscribed on messages
  void onStreamMessage(M message);

  HasMessageProviders get _gameRefWithProgress {
    final game = findGame();
    assert(
      game != null,
      "Notifier can't be used without Game",
    );
    assert(
      game is HasMessageProviders,
      'Game must have HasProgressNotifier mixin',
    );
    return game! as HasMessageProviders;
  }

  StreamSubscription<M>? _streamSubscription;

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();

    final stream = _gameRefWithProgress.messageProvidersManager
        .getMessageProvider<M>(streamName)
        .messagingStream;
    _streamSubscription = stream.listen(onStreamMessage);
  }

  @override
  @mustCallSuper
  void onRemove() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.onRemove();
  }
}
