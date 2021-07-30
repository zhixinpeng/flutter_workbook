import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final localeReducer = combineReducers<Locale?>([
  TypedReducer<Locale?, UpdateLocaleAction>(_updateLocale),
]);

Locale? _updateLocale(Locale? locale, UpdateLocaleAction action) {
  locale = action.locale;
  return locale;
}

class UpdateLocaleAction {
  final Locale? locale;

  UpdateLocaleAction(this.locale);
}
