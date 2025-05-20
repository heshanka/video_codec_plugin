package com.example.video_codec_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.media.MediaExtractor
import android.media.MediaFormat
import android.net.Uri

class VideoCodecPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "video_codec_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "detectVideoCodec") {
            val videoURLString = call.argument<String>("url")
            if (videoURLString != null) {
                detectVideoCodec(videoURLString, result)
            } else {
                result.error("INVALID_ARGUMENTS", "Invalid URL", null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun detectVideoCodec(videoURLString: String, result: Result) {
        val uri = Uri.parse(videoURLString)
        var extractor: MediaExtractor? = null
        try {
            extractor = MediaExtractor()
            extractor.setDataSource(uri.path!!) 

            var videoTrackIndex = -1
            for (i in 0 until extractor.trackCount) {
                val format = extractor.getTrackFormat(i)
                val mime = format.getString(MediaFormat.KEY_MIME)
                if (mime?.startsWith("video/") == true) {
                    videoTrackIndex = i
                    break
                }
            }

            if (videoTrackIndex != -1) {
                val videoFormat = extractor.getTrackFormat(videoTrackIndex)
                val codec = videoFormat.getString(MediaFormat.KEY_MIME)
                result.success(codec)
            } else {
                result.success("No video track found")
            }
        } catch (e: Exception) {
            result.error("CODEC_DETECTION_ERROR", "Failed to detect codec: ${e.localizedMessage}", null)
        } finally {
            extractor?.release()
        }
    }
}