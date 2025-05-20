# video_codec_plugin

A Flutter plugin to detect the codec of a video file on Android and iOS.

## Features

- Detects the video codec (e.g., `avc1`, `hvc1`, etc.) from a local video file.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  video_codec_plugin: ^1.1.0
````

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:video_codec_plugin/video_codec_plugin.dart';

final plugin = VideoCodecPlugin();

Future<void> detectCodec(String filePath) async {
  final codec = await plugin.detectVideoCodec(filePath);
  print('Detected codec: $codec');
}
```

## Platform Support

* ✅ iOS
* ✅  Android (not yet supported)

## License

MIT

