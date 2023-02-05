import 'package:flame/game.dart';
import 'package:flame_message_stream/flame_message_stream.dart';

/// This class allows a [Game] to have multiple messaging streams with different
/// message types. Use [getMessageProvider] to create or retrieve an existing
/// stream provider. Most probably this is all you need, but with
/// [removeMessageProvider] you can also manually delete the provider.
/// Both functions have type parameter, which should not be omitted, because
/// stream providers with same name but different type are not equal. The mixin
/// allows to create only one provider for specified name.
mixin HasMessageProviders on Game {
  final _providers = <String, MessageStreamProvider>{};

  /// Creates or retrieves existing stream provider by name.
  MessageStreamProvider<M> getMessageProvider<M>(String name) {
    final provider = _providers[name];
    if (provider is MessageStreamProvider<M>) {
      return provider;
    } else if (provider == null) {
      final provider = _providers[name] = MessageStreamProvider<M>();
      return provider;
    } else {
      throw "Provider '$name' does not match given type '${M.runtimeType}'";
    }
  }

  void removeMessageProvider<M>(String name) {
    final provider = _providers[name];

    if (provider is MessageStreamProvider<M>) {
      _providers.remove(name);
      provider.dispose();
    }
  }

  @override
  void detach() {
    for (final provider in _providers.values) {
      provider.dispose();
    }
    _providers.clear();
    super.detach();
  }
}
