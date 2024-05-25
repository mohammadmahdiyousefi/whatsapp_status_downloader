import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathDirectory {
  static Future<String> getApplicationDirectoryPath() async {
    final Directory? directory = await getExternalStorageDirectory();
    return directory!.path.substring(0, directory.path.indexOf("/Android"));
  }

  static Future<String> getSaveFileDirectoryPath() async {
    final appDirectory = await getApplicationDirectoryPath();
    return '$appDirectory/Download/Whatsapp Status';
  }

  static Future<String> getWhatsappDirectoryPath() async {
    final appDirectory = await getApplicationDirectoryPath();
    return '$appDirectory/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
  }

  static Future<String> getWhatsappBuisnessDirectoryPath() async {
    final appDirectory = await getApplicationDirectoryPath();
    return '$appDirectory/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';
  }
}
