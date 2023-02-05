## Features

Simple set of utilities to make streams management in Flame a little bit easier

## Usage

Streams could be used to communicate between components, between game and components and (which is
most useful) between game and flutter widgets, including widgets from overlays.

Use `MessageStreamProvider` to add ability to send messages for any class of application:

```dart
class AnyClass {
  /// Create provider instance with strict type of message you want to send
  final _provider = MessageStreamProvider<String>();

  /// Don't forget to make [messagingStream] available to allow external classes subscribe on it  
  Stream<String> get messagingStream => _provider.messagingStream;

  /// Just send a data to subscribers anywhere from class logics
  void classMainFunction() {
    _provider.sendMessage('message text');
  }

  /// don't forget to free resources
  void dispose() {
    _provider.dispose();
  }
}
```

Use `MessageListener` mixin to listen messages in Flame's components.

```dart

/// Specify message type for [MessageListener] mixin. It must be same as for [MessageStreamProvider]
/// you used to send messages
class MessageReceiver extends Component with MessageListener<String> {

  /// Specify the name of stream on which this component will be subscribed
  @override
  String get streamName => 'string_stream';

  /// Store data anywhere, it it is needed
  String lastMessageData = '';

  /// Implement this function to receive messages to your component
  @override
  void onStreamMessage(String message) {
    lastMessageData = message;
  }

  /// Do anything with saved data anywhere in your component's logic, for example in [update]
  /// function
  @override
  update(double dt) {
    print(lastMessageData);
    super.update(dt);
  }
}
```

Then use `HasMessageProviders` mixin for Game class to have ability to send messages from the game
This mixin allows to create multiple streams with different type of messages and retrieve it
by string identifier

```dart

/// Example class representing message
@immutable
class ExampleMessage {
  ExampleMessage(this.text, this.value)

  final String text;
  final int value;
}

/// Add [HasMessageProviders] to the game class
class MyGame extends FlameGame with HasMessageProviders {

  /// Create streams by name and type to subscribe on them from anywhere 
  /// (from onLoad function just for example)
  onLoad() {
    /// create a component with [MessageListener] mixin. It will subscribe to corresponding 
    /// stream automatically. The stream vill also be created automatically, if not exists.
    final stringListener = MessageReceiver();

    /// Just add this component to game
    add(stringListener);

    /// You also could access a stream directly using it's unique string name and type of message
    /// New stream will be created automatically, if not exists.
    final streamOfMessages = getMessageProvider<ExampleMessage>('msg_stream').messagingStream;
  }


  /// Just get a provider you need and send message of corresponding type.
  void anyFunctionWithLogic() {
    getMessageProvider<String>('string_stream').sendMessage('Hello, World!');
    getMessageProvider<ExampleMessage>('msg_stream').sendMessage(ExampleMessage('Hi!', 42));
    getMessageProvider<ExampleMessage>('msg_stream').sendMessage(ExampleMessage('Bye!', 404));
  }
}

```

## Additional information

This is a basic framework to let Flame communicate with it's internals and with external Flutter
infrastructure using streams. But concrete scenario is up to you, brave developer! Use this powers
wisely!