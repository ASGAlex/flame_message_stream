/// Simple base classes wor easy management of streams in Flame
/// Use "MessageStreamProvider" to add ability to send messages for any class of
/// application.
/// Use "MessageListener" mixin to listen messages in Flame's components
/// Use "HasMessageProviders" mixin for Game class to have ability to send
/// messages from the game
///
/// Streams could be used to communicate between components, between game and
/// components and (which is most useful) between game and flutter widgets,
/// including widgets from overlays.

library flame_message_stream;

export 'src/has_message_providers.dart';
export 'src/message_listener.dart';
export 'src/message_stream_provider.dart';
