import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_status_downloader/data/local_repository/image_repository.dart';
import 'package:whatsapp_status_downloader/di/di.dart';

part 'whatsapp_image_status_event.dart';
part 'whatsapp_image_status_state.dart';

class WhatsappImageStatusBloc
    extends Bloc<WhatsappImageStatusEvent, WhatsappImageStatusState> {
  WhatsappImageStatusBloc() : super(WhatsappImageStatusInitial()) {
    final ImageRepository repository = locator.get();
    on<WhatsappImageStatusGet>((event, emit) async {
      emit(WhatsappImageStatusLoading());
      Either<String, List<File>> response = await repository.getImage();
      response.fold((error) {
        emit(WhatsappImageStatusError(message: error));
      }, (data) {
        if (data.isEmpty) {
          emit(WhatsappImageStatusEmpty());
        } else {
          emit(WhatsappImageStatusData(data));
        }
      });
    });
  }
}
