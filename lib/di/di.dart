import 'package:get_it/get_it.dart';
import 'package:whatsapp_status_downloader/bloc/file_storage/file_srorage_bloc.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/filestorage_data_source.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/image_data_sourc.dart';
import 'package:whatsapp_status_downloader/data/local_data_source/video_data_source.dart';
import 'package:whatsapp_status_downloader/data/local_repository/file_storage_repository.dart';
import 'package:whatsapp_status_downloader/data/local_repository/image_repository.dart';
import 'package:whatsapp_status_downloader/data/local_repository/video_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //DataSource
  locator.registerFactory<ImageDataSource>(() => GetImageDatasource());
  locator.registerFactory<VideoDataSource>(() => GetVideoDatasource());
  locator
      .registerFactory<FileStorageDataSource>(() => GetFileStorageDatasource());
  //Reapository
  locator.registerFactory<ImageRepository>(() => GetImageRepository());
  locator.registerFactory<VideoRepository>(() => GetVideoRepository());
  locator
      .registerFactory<FileStorageRepository>(() => GetFileStorageRepository());

  //bloc
  locator.registerSingleton(FileSrorageBloc());
}
