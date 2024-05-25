part of 'file_srorage_bloc.dart';

sealed class FileSrorageEvent extends Equatable {
  const FileSrorageEvent();

  @override
  List<Object> get props => [];
}

class FileSrorageGetEvent extends FileSrorageEvent {}

class FileSrorageRefreshEvent extends FileSrorageEvent {}
