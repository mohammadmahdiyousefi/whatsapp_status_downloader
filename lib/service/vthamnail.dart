import 'dart:io';

import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoThumbnail {
  static FcNativeVideoThumbnail thumbnail = FcNativeVideoThumbnail();
  static Future<String> getThumbnail(String path) async {
    try {
      final Directory dir = await getTemporaryDirectory();
      String thumbnailPath =
          "${dir.path}/${path.split("/").last.split(".").first}.png";
      bool success = await thumbnail.getVideoThumbnail(
        srcFile: path,
        destFile: thumbnailPath,
        width: 1000,
        height: 1000,
        quality: 100,
        keepAspectRatio: true,
      );

      if (!success) {
        throw "خطا در بارگذاری فایل";
      }

      return thumbnailPath;
    } catch (e) {
      throw throw "خطا در بارگذاری فایل";
    }
  }
}
