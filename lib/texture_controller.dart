import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TextureController {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('texture_controller');

  late int textureId;

  Future<void> initialize(double width, double height) async {
    textureId = await methodChannel.invokeMethod('create', {
      'width': width,
      'height': height,
    });
  }

  Future<void> dispose() =>
      methodChannel.invokeMethod('dispose', {'textureId': textureId});
}
