import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/utils/logger.dart';

@injectable
class LogsMiddleware {
  List<Middleware<AppState>> _middleware;
  Iterable<Middleware<AppState>> get middleware =>
      _middleware ?? (_middleware = _createMiddleware());

  List<Middleware<AppState>> _createMiddleware() => [
        TypedMiddleware<AppState, dynamic>(_log),
      ];

  void _log(Store<AppState> store, dynamic action, NextDispatcher next) {
    log(action.runtimeType);

    next(action);
  }
}
