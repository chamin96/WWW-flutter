import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:what_when_where/common/app_theme.dart';
import 'package:what_when_where/common/text_scale.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/browsing/actions.dart';
import 'package:what_when_where/redux/developer/actions.dart';
import 'package:what_when_where/redux/dialogs/actions.dart';
import 'package:what_when_where/redux/navigation/actions.dart';
import 'package:what_when_where/redux/questions/actions.dart';
import 'package:what_when_where/redux/rating/actions.dart';
import 'package:what_when_where/redux/redux_action.dart';
import 'package:what_when_where/redux/search/actions.dart';
import 'package:what_when_where/redux/settings/actions.dart';
import 'package:what_when_where/redux/sharing/actions.dart';
import 'package:what_when_where/redux/timer/actions.dart';
import 'package:what_when_where/redux/tournament/actions.dart';
import 'package:what_when_where/redux/tree/actions.dart';
import 'package:what_when_where/services/analytics.dart';

final _analyticsEventNames = {
  // timer
  '$StartTimerUserAction': 'start_timer',
  '$StopTimerUserAction': 'pause_timer',
  '$ChangeTypeTimerUserAction': 'timer_type_set',
  // answer
  '$ShowAnswerQuestionsUserAction': 'show_answer',
  '$HideAnswerQuestionsUserAction': 'hide_answer',
  // sharing
  '$QuestionSharingUserAction': 'share_question',
  '$TourSharingUserAction': 'share_tour',
  '$TournamentSharingUserAction': 'share_tournament',
  // browsing
  '$QuestionBrowseUserAction': 'browse_question',
  '$TourBrowseUserAction': 'browse_tour',
  '$TournamentBrowseUserAction': 'browse_tournament',
  '$DatabaseBrowseUserAction': 'browse_database',
  // navigation
  '$ImageNavigationUserAction': 'open_image',
  '$AboutNavigationUserAction': 'about',
  '$TourInfoDialogUserAction': 'open_tour_info',
  '$TournamentInfoDialogUserAction': 'open_tournament_info',
  '$OpenSettingsUserAction': 'settings',
  '$OpenTournamentUserAction': 'tournament',
  '$OpenSearchUserAction': 'search',
  '$OpenRandomQuestionsUserAction': 'random',
  // developer
  '$EmailDeveloperUserAction': 'email_developers',
  '$VisitWebsiteDeveloperUserAction': 'visit_developers_website',
  // misc
  '$NeverAskRatingUserAction': 'rate_never',
};

@injectable
class AnalyticsMiddleware {
  final IAnalyticsService _analyticsService;

  List<Middleware<AppState>> _middleware;

  Iterable<Middleware<AppState>> get middleware =>
      _middleware ?? (_middleware = _createMiddleware());

  AnalyticsMiddleware({
    IAnalyticsService analyticsService,
  }) : _analyticsService = analyticsService;

  List<Middleware<AppState>> _createMiddleware() => [
        TypedMiddleware<AppState, StartTimerUserAction>(_logAction),
        TypedMiddleware<AppState, StopTimerUserAction>(_logAction),
        TypedMiddleware<AppState, ChangeTypeTimerUserAction>(_logAction),
        TypedMiddleware<AppState, ShowAnswerQuestionsUserAction>(_logAction),
        TypedMiddleware<AppState, HideAnswerQuestionsUserAction>(_logAction),
        TypedMiddleware<AppState, QuestionSharingUserAction>(_logAction),
        TypedMiddleware<AppState, TourSharingUserAction>(_logAction),
        TypedMiddleware<AppState, TournamentSharingUserAction>(_logAction),
        TypedMiddleware<AppState, TournamentBrowseUserAction>(_logAction),
        TypedMiddleware<AppState, TourBrowseUserAction>(_logAction),
        TypedMiddleware<AppState, QuestionBrowseUserAction>(_logAction),
        TypedMiddleware<AppState, ImageNavigationUserAction>(_logAction),
        TypedMiddleware<AppState, AboutNavigationUserAction>(_logAction),
        TypedMiddleware<AppState, TourInfoDialogUserAction>(_logAction),
        TypedMiddleware<AppState, TournamentInfoDialogUserAction>(_logAction),
        TypedMiddleware<AppState, EmailDeveloperUserAction>(_logAction),
        TypedMiddleware<AppState, VisitWebsiteDeveloperUserAction>(_logAction),
        TypedMiddleware<AppState, DatabaseBrowseUserAction>(_logAction),
        TypedMiddleware<AppState, OpenTournamentUserAction>(_logAction),
        TypedMiddleware<AppState, OpenSearchUserAction>(_logAction),
        TypedMiddleware<AppState, OpenSettingsUserAction>(_logAction),
        TypedMiddleware<AppState, OpenRandomQuestionsUserAction>(_logAction),
        TypedMiddleware<AppState, OpenTournamentsTreeUserAction>(_logAction),
        TypedMiddleware<AppState, NeverAskRatingUserAction>(_logAction),
        // settings
        TypedMiddleware<AppState, ReadySettingsSystemAction>(_logSettings),
        TypedMiddleware<AppState, ChangeThemeSettingsUserAction>(_logTheme),
        TypedMiddleware<AppState, ChangeTextScaleSettingsUserAction>(
            _logTextScale),
        TypedMiddleware<AppState,
                ChangeNotifyShortTimerExpirationSettingsUserAction>(
            _logNotifyShortTimerExpiration),
        TypedMiddleware<AppState,
                ChangeNotifyLongTimerExpirationSettingsUserAction>(
            _logNotifyLongTimerExpiration),
        // misc
        TypedMiddleware<AppState, RateRatingUserAction>(_logRating),
        TypedMiddleware<AppState, OpenTournamentsTreeUserAction>(_logTree),
      ];

  void _logAction(
      Store<AppState> store, ReduxAction action, NextDispatcher next) {
    next(action);

    final actionType =
        action.runtimeType.toString().replaceAll(r'$', '').replaceAll('_', '');

    _analyticsService.logEvent(name: _analyticsEventNames[actionType]);
  }

  void _logSettings(Store<AppState> store, ReadySettingsSystemAction action,
      NextDispatcher next) {
    next(action);

    _logThemeValue(action.appTheme);
    _logTextScaleValue(action.textScale);
    _logNotifyShortTimerExpirationValue(action.notifyShortTimerExpiration);
    _logNotifyLongTimerExpirationValue(action.notifyLongTimerExpiration);
  }

  void _logTheme(Store<AppState> store, ChangeThemeSettingsUserAction action,
      NextDispatcher next) {
    next(action);

    _logThemeValue(action.appTheme);
  }

  void _logThemeValue(AppTheme appTheme) => _analyticsService.logEvent(
        name: 'theme',
        parameters: <String, String>{
          'value': appTheme.toString().split('.').last
        },
      );

  void _logTextScale(Store<AppState> store,
      ChangeTextScaleSettingsUserAction action, NextDispatcher next) {
    next(action);

    _logTextScaleValue(action.textScale);
  }

  void _logTextScaleValue(TextScale textScale) => _analyticsService.logEvent(
        name: 'textScale',
        parameters: <String, String>{
          'value': textScale.toString().split('.').last
        },
      );

  void _logNotifyShortTimerExpiration(
      Store<AppState> store,
      ChangeNotifyShortTimerExpirationSettingsUserAction action,
      NextDispatcher next) {
    next(action);

    _logNotifyShortTimerExpirationValue(action.value);
  }

  void _logNotifyShortTimerExpirationValue(bool value) =>
      _analyticsService.logEvent(
        name: 'timer_notifications',
        parameters: <String, String>{
          'short_timer': value.toString(),
        },
      );

  void _logNotifyLongTimerExpiration(
      Store<AppState> store,
      ChangeNotifyLongTimerExpirationSettingsUserAction action,
      NextDispatcher next) {
    next(action);

    _logNotifyLongTimerExpirationValue(action.value);
  }

  void _logNotifyLongTimerExpirationValue(bool value) =>
      _analyticsService.logEvent(
        name: 'timer_notifications',
        parameters: <String, String>{
          'long_timer': value.toString(),
        },
      );

  void _logRating(
      Store<AppState> store, RateRatingUserAction action, NextDispatcher next) {
    next(action);

    _analyticsService.logEvent(
      name: 'rate',
      parameters: <String, String>{
        'rating': action.rating.toString(),
      },
    );
  }

  void _logTree(
      Store<AppState> store, OpenTournamentsTreeUserAction action, next) {
    next(action);

    if (action.info == null) {
      _analyticsService.logEvent(name: 'tree');
    }
  }
}
