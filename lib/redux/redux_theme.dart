import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final themeDataReducer = combineReducers<ThemeData?>([
  TypedReducer<ThemeData?, UpdateThemeDataAction>(_updateTheme),
]);

ThemeData? _updateTheme(ThemeData? themeData, UpdateThemeDataAction action) {
  themeData = action.themeData;
  return themeData;
}

class UpdateThemeDataAction {
  final ThemeData themeData;

  UpdateThemeDataAction(this.themeData);
}
