import 'package:flame/game.dart';
import 'package:flame_message_stream/flame_message_stream.dart';

mixin HasMessageProviders on Game {
  final messageProvidersManager = MessageProvidersManager();

  @override
  void onRemove() {
    messageProvidersManager.dispose();
    super.onRemove();
  }
}
