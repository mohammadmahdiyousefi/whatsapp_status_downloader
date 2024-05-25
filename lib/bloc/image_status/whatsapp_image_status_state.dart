part of 'whatsapp_image_status_bloc.dart';

sealed class WhatsappImageStatusState extends Equatable {
  const WhatsappImageStatusState();

  @override
  List<Object> get props => [];
}

final class WhatsappImageStatusInitial extends WhatsappImageStatusState {}

final class WhatsappImageStatusLoading extends WhatsappImageStatusState {}

final class WhatsappImageStatusData extends WhatsappImageStatusState {
  final List<File> images;
  const WhatsappImageStatusData(this.images);
  @override
  List<Object> get props => [images];
}

final class WhatsappImageStatusEmpty extends WhatsappImageStatusState {}

final class WhatsappImageStatusError extends WhatsappImageStatusState {
  final String message;
  const WhatsappImageStatusError({required this.message});
  @override
  List<Object> get props => [message];
}
