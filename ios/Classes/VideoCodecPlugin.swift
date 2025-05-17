import Flutter
import UIKit
import AVFoundation

public class VideoCodecPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "video_codec_plugin", binaryMessenger: registrar.messenger())
    let instance = VideoCodecPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "detectVideoCodec" {
      guard let args = call.arguments as? [String: Any],
            let videoURLString = args["url"] as? String else {
        result(FlutterError(code: "invalid_arguments", message: "Invalid URL", details: nil))
        return
      }

      let videoURL = URL(fileURLWithPath: videoURLString)
      detectVideoCodec(forURL: videoURL) { codec in
        result(codec)
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func detectVideoCodec(forURL videoURL: URL, completion: @escaping (String) -> Void) {
    let asset = AVAsset(url: videoURL)
    asset.loadValuesAsynchronously(forKeys: ["tracks"]) {
      var error: NSError? = nil
      let status = asset.statusOfValue(forKey: "tracks", error: &error)
      if status == .loaded {
        guard let videoTrack = asset.tracks(withMediaType: .video).first,
              let formatDescriptionAny = videoTrack.formatDescriptions.first else {
          completion("No video track or format found")
          return
        }

        let formatDescription = formatDescriptionAny as! CMFormatDescription
        let codecType = CMFormatDescriptionGetMediaSubType(formatDescription)
        completion(self.fourCCToString(from: codecType))
      } else {
        completion("Failed to load tracks: \(error?.localizedDescription ?? "Unknown error")")
      }
    }
  }

  private func fourCCToString(from fourCC: CMVideoCodecType) -> String {
    var codecChars = [CChar](repeating: 0, count: 5)
    var bigEndianFourCC = fourCC.bigEndian
    memcpy(&codecChars, &bigEndianFourCC, 4)
    return String(cString: codecChars)
  }
}
