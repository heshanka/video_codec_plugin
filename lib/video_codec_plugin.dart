
import 'package:flutter/services.dart';

class VideoCodecPlugin {
  static const MethodChannel _channel = MethodChannel('video_codec_plugin');

  Future<String?> detectVideoCodec(String videoUrl) async {
    String cleanedUrl = videoUrl.replaceAll(RegExp(r'\?+$'), '');

    try {
      final String result = await _channel.invokeMethod(
        'detectVideoCodec',
        {'url': cleanedUrl},
      );
      return result;
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }
}
