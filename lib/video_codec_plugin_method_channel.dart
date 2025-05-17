import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_codec_plugin_platform_interface.dart';

/// An implementation of [VideoCodecPluginPlatform] that uses method channels.
class MethodChannelVideoCodecPlugin extends VideoCodecPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_codec_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
