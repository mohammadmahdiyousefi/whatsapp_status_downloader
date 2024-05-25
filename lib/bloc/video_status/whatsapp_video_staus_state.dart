part of 'whatsapp_video_staus_bloc.dart';

sealed class WhatsappVideoStausState extends Equatable {
  const WhatsappVideoStausState();

  @override
  List<Object> get props => [];
}

final class WhatsappVideoStatusInitial extends WhatsappVideoStausState {}

final class WhatsappVideoStatusLoading extends WhatsappVideoStausState {}

final class WhatsappVideoStatusData extends WhatsappVideoStausState {
  final List<File> videos;
  const WhatsappVideoStatusData(this.videos);
  @override
  List<Object> get props => [videos];
}

final class WhatsappVideoStatusEmpty extends WhatsappVideoStausState {}

final class WhatsappVideoStatusError extends WhatsappVideoStausState {
  final String message;
  const WhatsappVideoStatusError(this.message);
  @override
  List<Object> get props => [message];
}
