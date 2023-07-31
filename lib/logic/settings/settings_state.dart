// ignore_for_file: overridden_fields

import 'package:flutter/foundation.dart';

@immutable
class SettingsCubitState {
  const SettingsCubitState();
}

@immutable
class SettingsSaveInitState extends SettingsCubitState {
  const SettingsSaveInitState();
}

@immutable
class SettingsSaveProgressState extends SettingsCubitState {
  const SettingsSaveProgressState();
}

@immutable
class SettingsSaveCompletedState extends SettingsCubitState {
  const SettingsSaveCompletedState();
}

@immutable
class SettingsSaveErrorState extends SettingsCubitState {
  const SettingsSaveErrorState();
}
