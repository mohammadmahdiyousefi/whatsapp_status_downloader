part of 'whatsapp_image_status_bloc.dart';

sealed class WhatsappImageStatusEvent extends Equatable {
  const WhatsappImageStatusEvent();

  @override
  List<Object> get props => [];
}

class WhatsappImageStatusGet extends WhatsappImageStatusEvent {}
