import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_status_downloader/data/local_repository/file_storage_repository.dart';
import 'package:whatsapp_status_downloader/di/di.dart';

part 'file_srorage_event.dart';
part 'file_srorage_state.dart';

class FileSrorageBloc extends Bloc<FileSrorageEvent, FileSrorageState> {
  FileSrorageBloc() : super(FileSrorageInitial()) {
    final FileStorageRepository repository = locator.get();
    on<FileSrorageGetEvent>((event, emit) async {
      emit(FileSrorageLoading());
      Either<String, List<File>> response = await repository.getFile();
      response.fold((error) {
        emit(FileSrorageError(message: error));
      }, (data) {
        if (data.isEmpty) {
          emit(FileSrorageEmpty());
        } else {
          emit(FileSrorageData(files: data));
        }
      });
    });
    on<FileSrorageRefreshEvent>((event, emit) async {
      Either<String, List<File>> response = await repository.getFile();
      response.fold((error) {
        emit(FileSrorageError(message: error));
      }, (data) {
        if (data.isEmpty) {
          emit(FileSrorageEmpty());
        } else {
          emit(FileSrorageData(files: data));
        }
      });
    });
  }
}
