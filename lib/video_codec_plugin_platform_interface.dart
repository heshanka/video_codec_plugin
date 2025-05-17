import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_codec_plugin_method_channel.dart';

abstract class VideoCodecPluginPlatform extends PlatformInterface {
  /// Constructs a VideoCodecPluginPlatform.
  VideoCodecPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoCodecPluginPlatform _instance = MethodChannelVideoCodecPlugin();

  /// The default instance of [VideoCodecPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoCodecPlugin].
  static VideoCodecPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoCodecPluginPlatform] when
  /// they register themselves.
  static set instance(VideoCodecPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
