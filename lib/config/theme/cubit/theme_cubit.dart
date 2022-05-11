import 'package:ap1/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(themes[THEME.dark]!);

  void changeLight() => emit(themes[THEME.light]!);
  void changeDark() => emit(themes[THEME.dark]!);
}
