import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingPageState>>{
      SettingPageAction.action: _onAction,
      SettingPageAction.adultValueUpadte: _adultValueUpadte,
      SettingPageAction.cachedSizeUpdate: _cachedSizeUpdate,
      SettingPageAction.userUpdate: _userUpdate,
      SettingPageAction.userPanelPhotoUrlUpdate: _userPanelPhotoUrlUpdate,
      SettingPageAction.uploading: _onUploading,
    },
  );
}

SettingPageState _onAction(SettingPageState state, Action action) {
  final SettingPageState newState = state.clone();
  return newState;
}

SettingPageState _onUploading(SettingPageState state, Action action) {
  final bool _isUploading = action.payload ?? false;
  final SettingPageState newState = state.clone();
  newState.uploading = _isUploading;
  return newState;
}

SettingPageState _adultValueUpadte(SettingPageState state, Action action) {
  final bool _b = action.payload;
  final SettingPageState newState = state.clone();
  newState.adultSwitchValue = _b;
  return newState;
}

SettingPageState _cachedSizeUpdate(SettingPageState state, Action action) {
  final double _c = action.payload;
  final SettingPageState newState = state.clone();
  newState.cachedSize = _c;
  return newState;
}

SettingPageState _userUpdate(SettingPageState state, Action action) {
  final FirebaseUser _user = action.payload;
  final SettingPageState newState = state.clone();
  newState.user = _user;
  newState.userName = _user.displayName;
  newState.photoUrl = _user.photoUrl;
  return newState;
}

SettingPageState _userPanelPhotoUrlUpdate(
    SettingPageState state, Action action) {
  final String _url = action.payload;
  final SettingPageState newState = state.clone();
  newState.userPanelPhotoUrl = _url;
  return newState;
}
