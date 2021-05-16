import 'package:redux/redux.dart';


void loggingMiddleware<State>(
    Store<State> store,
    dynamic action,
    NextDispatcher next,
) {
    print(action);
    next(action);
}