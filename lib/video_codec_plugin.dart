
import 'video_codec_plugin_platform_interface.dart';

class VideoCodecPlugin {
  Future<String?> getPlatformVersion() {
    return VideoCodecPluginPlatform.instance.getPlatformVersion();
  }
}
