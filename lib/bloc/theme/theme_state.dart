import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final String appLanguage;
  const ThemeState({required this.mode, required this.appLanguage});
  @override
  List<Object> get props => [mode, appLanguage];
  ThemeState copyWith({String? selectedLanguage, ThemeMode? newmode}) {
    return ThemeState(
        mode: newmode ?? mode, appLanguage: selectedLanguage ?? appLanguage);
  }
}
