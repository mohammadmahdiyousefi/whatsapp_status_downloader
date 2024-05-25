import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/image_data_sourc.dart';
import 'package:whatsapp_status_downloader/di/di.dart';

abstract class ImageRepository {
  Future<Either<String, List<File>>> getImage();
}

class GetImageRepository extends ImageRepository {
  final ImageDataSource _datasours = locator.get();

  @override
  Future<Either<String, List<File>>> getImage() async {
    try {
      var respons = await _datasours.getImage();
      return right(respons);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
