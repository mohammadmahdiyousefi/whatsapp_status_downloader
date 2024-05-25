import 'dart:io';

import 'package:whatsapp_status_downloader/service/get_directory_path.dart';
import 'package:whatsapp_status_downloader/service/permission/premission.dart';

abstract class ImageDataSource {
  Future<List<File>> getImage();
}

class GetImageDatasource extends ImageDataSource {
  String wdirectoryPath = '';
  String wbDirectoryPath = '';
  List<FileSystemEntity> entities = [];
  @override
  Future<List<File>> getImage() async {
    try {
      entities.clear();
      final bool status = await AppPremission.storageStatus();
      if (status == true) {
        wdirectoryPath = await PathDirectory.getWhatsappDirectoryPath();
        wbDirectoryPath =
            await PathDirectory.getWhatsappBuisnessDirectoryPath();
        if (await Directory(wdirectoryPath).exists()) {
          entities.addAll(Directory(wdirectoryPath).listSync());
        }
        if (await Directory(wbDirectoryPath).exists()) {
          entities.addAll(Directory(wbDirectoryPath).listSync());
        }
        List<File> imageFiles = entities.whereType<File>().where((file) {
          String extension = file.path.split('.').last.toLowerCase();
          return extension == 'jpg' ||
              extension == 'jpeg' ||
              extension == 'png' ||
              extension == 'gif' ||
              extension == 'bmp';
        }).toList();
        return imageFiles;
      } else {
        throw "لطفا دسترسی به داده ها را فعال کنید.";
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
