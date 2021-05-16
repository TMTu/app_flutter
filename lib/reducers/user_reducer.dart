import 'dart:convert';

import 'package:app_flutter/actions/user_action.dart';

import 'package:app_flutter/models/user/user.dart';
import 'package:app_flutter/models/user/user_state.dart';

UserState userReducer(UserState state, action) {
  UserState newState = state;
  print(action);
  switch (action['type']) {
    case LIST_USERS_REQUEST:
      newState.list.error = null;
      newState.list.loading = true;
      newState.list.data = null;
      return newState;

    case LIST_USERS_SUCCESS:
      newState.list.error = null;
      newState.list.loading = false;
      newState.list.data = action['data'];
      return newState;

    case LIST_USERS_FAILURE:
      newState.list.error = null;
      newState.list.loading = false;
      newState.list.data = null;
      return newState;


    case GET_USER_DETAILS_REQUEST:
      newState.details.error = null;
      newState.details.loading = true;
      newState.details.data = null;
      return newState;

    case GET_USER_DETAILS_SUCCESS:
      newState.details.error = null;
      newState.details.loading = false;
      newState.details.data = action['data'];
      return newState;

    case GET_USER_DETAILS_FAILURE:
      newState.details.error = null;
      newState.details.loading = true;
      newState.details.data = null;
      return newState;

    case ADD_USER_SUCCESS:
      newState.list.data.add(action['data']);
      return newState;

    case UPDATE_USER_SUCCESS:
      newState.list.data.removeAt(action['index']);
      newState.list.data.add(action['data']);
      return newState;

    case DELETE_USER_SUCCESS:
      newState.list.data.removeAt(action['index']);
      return newState;
    default:
      return newState;
  }
}