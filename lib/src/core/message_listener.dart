import 'dart:async';

import 'package:flame_message_stream/flame_message_stream.dart';

abstract class MessageListener<M> {
  MessageListener(MessageStreamProvider<M> provider) {
    final stream = provider.messagingStream;
    _streamSubscription = stream.listen(onStreamMessage);
  }

  StreamSubscription<M>? _streamSubscription;

  void onStreamMessage(M message);

  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}

mixin MessageListenerMixin<M> {
  void listenProvider(MessageStreamProvider<M> provider) {
    final stream = provider.messagingStream;
    _streamSubscription = stream.listen(onStreamMessage);
  }

  StreamSubscription<M>? _streamSubscription;

  void onStreamMessage(M message);

  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}
