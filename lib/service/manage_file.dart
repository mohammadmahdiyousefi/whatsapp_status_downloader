import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whatsapp_status_downloader/service/get_directory_path.dart';

class ManageFile {
  static String directoryPath = '';
  static Future<Either<String, bool>> deleteFile(File file) async {
    try {
      directoryPath = await PathDirectory.getSaveFileDirectoryPath();
      final File newfile = File("$directoryPath/${file.path.split('/').last}");
      if (newfile.existsSync()) {
        await newfile.delete();
      }

      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, bool>> saveFile(File file) async {
    try {
      directoryPath = await PathDirectory.getSaveFileDirectoryPath();
      if (await Directory(directoryPath).exists()) {
        final String filePath = '$directoryPath/${file.path.split('/').last}';
        await file.copy(filePath);
        return right(true);
      } else {
        await Directory(directoryPath).create();
        return saveFile(file);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
