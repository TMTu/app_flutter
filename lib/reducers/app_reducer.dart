import 'package:app_flutter/models/app_state.dart';
import 'package:app_flutter/reducers/user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}