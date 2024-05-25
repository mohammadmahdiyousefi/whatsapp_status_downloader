import 'dart:io';
import 'package:whatsapp_status_downloader/service/get_directory_path.dart';
import 'package:whatsapp_status_downloader/service/permission/premission.dart';

abstract class VideoDataSource {
  Future<List<File>> getVideo();
}

class GetVideoDatasource extends VideoDataSource {
  String wdirectoryPath = '';
  String wbDirectoryPath = '';
  List<FileSystemEntity> entities = [];
  @override
  Future<List<File>> getVideo() async {
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
        List<File> videoFiles = entities.whereType<File>().where((file) {
          String extension = file.path.split('.').last.toLowerCase();
          return extension == 'mp4' ||
              extension == 'mov' ||
              extension == 'avi' ||
              extension == 'wmv' ||
              extension == 'flv';
        }).toList();
        return videoFiles;
      } else {
        throw "لطفا دسترسی به داده ها را فعال کنید";
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
