import 'dart:async';

import 'package:flutter/services.dart';

class OpenGLTextureController {
  static const MethodChannel _channel = const MethodChannel('opengl_texture');

  int textureId = -1;

  Future<int> initialize(double width, double height) async {
    if (isShow) {
      return textureId;
    }
    textureId = await _channel.invokeMethod('create', {
      'width': width,
      'height': height,
    });
    return textureId;
  }

  Future<Null> dispose() async {
    await _channel.invokeMethod('dispose', {'textureId': textureId});
    textureId = -1;
  }

  bool get isShow => textureId >= 0;
}
