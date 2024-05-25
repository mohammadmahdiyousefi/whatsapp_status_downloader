part of 'file_srorage_bloc.dart';

sealed class FileSrorageState extends Equatable {
  const FileSrorageState();

  @override
  List<Object> get props => [];
}

final class FileSrorageInitial extends FileSrorageState {}

final class FileSrorageLoading extends FileSrorageState {}

final class FileSrorageData extends FileSrorageState {
  final List<File> files;
  const FileSrorageData({required this.files});
  @override
  List<Object> get props => [files];
}

final class FileSrorageEmpty extends FileSrorageState {}

final class FileSrorageError extends FileSrorageState {
  final String message;
  const FileSrorageError({required this.message});
  @override
  List<Object> get props => [message];
}
