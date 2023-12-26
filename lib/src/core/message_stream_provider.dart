import 'dart:async';

/// Message provider is responsible for creating single broadcast stream
/// with specified message type.
/// Use [messagingStream] to get a new or existing stream to subscribe.
/// Use [sendMessage] to send messages to subscribers then.
class MessageStreamProvider<M> {
  MessageStreamProvider({this.sync = true});

  StreamController<M>? _loadingStreamController;

  final bool sync;

  /// Sends a message to all subscribers
  void sendMessage(M message) => _loadingStreamController?.add(message);

  /// Creates new or returns existing stream of messages
  Stream<M> get messagingStream {
    final stream = _loadingStreamController?.stream;
    if (stream != null) {
      return stream;
    }
    _loadingStreamController = StreamController<M>.broadcast(sync: sync);
    return _loadingStreamController!.stream;
  }

  void dispose() {
    _loadingStreamController?.close();
    _loadingStreamController = null;
  }
}
