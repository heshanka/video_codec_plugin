import 'package:flutter_test/flutter_test.dart';
import 'package:video_codec_plugin/video_codec_plugin.dart';
import 'package:video_codec_plugin/video_codec_plugin_platform_interface.dart';
import 'package:video_codec_plugin/video_codec_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVideoCodecPluginPlatform
    with MockPlatformInterfaceMixin
    implements VideoCodecPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VideoCodecPluginPlatform initialPlatform = VideoCodecPluginPlatform.instance;

  test('$MethodChannelVideoCodecPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVideoCodecPlugin>());
  });

  test('getPlatformVersion', () async {
    VideoCodecPlugin videoCodecPlugin = VideoCodecPlugin();
    MockVideoCodecPluginPlatform fakePlatform = MockVideoCodecPluginPlatform();
    VideoCodecPluginPlatform.instance = fakePlatform;

    expect(await videoCodecPlugin.getPlatformVersion(), '42');
  });
}
