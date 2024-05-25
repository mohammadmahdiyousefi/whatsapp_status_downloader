part of 'whatsapp_video_staus_bloc.dart';

sealed class WhatsappVideoStausEvent extends Equatable {
  const WhatsappVideoStausEvent();

  @override
  List<Object> get props => [];
}

class WhatsappVideoStatusGet extends WhatsappVideoStausEvent {}
