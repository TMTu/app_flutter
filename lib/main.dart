import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:app_flutter/logger.dart';
import 'package:app_flutter/routes.dart';

import 'package:app_flutter/models/app_state.dart';
import 'package:app_flutter/reducers/app_reducer.dart';

import 'package:app_flutter/components/user/user_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, loggingMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        title: "Flutter with redux",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.users: (context) => UsersScreen(),
        },
      ),
    );
  }
}