import 'dart:io';

import 'package:whatsapp_status_downloader/service/get_directory_path.dart';

abstract class FileStorageDataSource {
  Future<List<File>> getFileList();
}

class GetFileStorageDatasource extends FileStorageDataSource {
  String directoryPath = '';

  @override
  Future<List<File>> getFileList() async {
    try {
      directoryPath = await PathDirectory.getSaveFileDirectoryPath();
      final List<File> files = _getFilesInDirectory(directoryPath);
      return files;
    } catch (ex) {
      throw ex.toString();
    }
  }

  List<File> _getFilesInDirectory(String directoryPath) {
    final List<FileSystemEntity> entities = Directory(directoryPath).listSync();
    final List<File> files = entities.whereType<File>().where((file) {
      final String extension = file.path.split('.').last.toLowerCase();
      return _isSupportedFileExtension(extension);
    }).toList();
    return files;
  }

  bool _isSupportedFileExtension(String extension) {
    const List<String> supportedExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'mp4',
      'mov',
      'avi',
      'wmv',
      'flv'
    ];
    return supportedExtensions.contains(extension.toLowerCase());
  }
}
