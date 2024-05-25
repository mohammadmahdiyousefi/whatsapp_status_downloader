import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_status_downloader/data/local_repository/video_repository.dart';
import 'package:whatsapp_status_downloader/di/di.dart';
part 'whatsapp_video_staus_event.dart';
part 'whatsapp_video_staus_state.dart';

class WhatsappVideoStausBloc
    extends Bloc<WhatsappVideoStausEvent, WhatsappVideoStausState> {
  WhatsappVideoStausBloc() : super(WhatsappVideoStatusInitial()) {
    final VideoRepository repository = locator.get();
    on<WhatsappVideoStatusGet>((event, emit) async {
      emit(WhatsappVideoStatusLoading());
      Either<String, List<File>> response = await repository.getVideo();
      response.fold((error) {
        emit(WhatsappVideoStatusError(error));
      }, (data) {
        if (data.isEmpty) {
          emit(WhatsappVideoStatusEmpty());
        } else {
          emit(WhatsappVideoStatusData(data));
        }
      });
    });
  }
}
