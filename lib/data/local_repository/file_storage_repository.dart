import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/filestorage_data_source.dart';
import 'package:whatsapp_status_downloader/di/di.dart';

abstract class FileStorageRepository {
  Future<Either<String, List<File>>> getFile();
}

class GetFileStorageRepository extends FileStorageRepository {
  final FileStorageDataSource _datasours = locator.get();

  @override
  Future<Either<String, List<File>>> getFile() async {
    try {
      var respons = await _datasours.getFileList();
      return right(respons);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
