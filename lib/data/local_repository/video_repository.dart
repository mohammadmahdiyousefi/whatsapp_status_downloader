import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/video_data_source.dart';

import 'package:whatsapp_status_downloader/di/di.dart';

abstract class VideoRepository {
  Future<Either<String, List<File>>> getVideo();
}

class GetVideoRepository extends VideoRepository {
  final VideoDataSource _datasours = locator.get();

  @override
  Future<Either<String, List<File>>> getVideo() async {
    try {
      var respons = await _datasours.getVideo();
      return right(respons);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
