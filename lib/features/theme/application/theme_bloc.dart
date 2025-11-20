
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './theme_event.dart';
import './theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeToggled>((event, emit) {
      if (state.themeMode == ThemeMode.light) {
        emit(const ThemeState(themeMode: ThemeMode.dark));
      } else {
        emit(const ThemeState(themeMode: ThemeMode.light));
      }
    });
    on<SystemThemeSet>((event, emit) {
      emit(const ThemeState(themeMode: ThemeMode.system));
    });
  }
}
