import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:what_when_where/data/models/tournament.dart';
import 'package:what_when_where/data/models/tournament_info.dart';
import 'package:what_when_where/data/models/tournament_status.dart';
import 'package:what_when_where/redux/redux_action.dart';

part 'actions.freezed.dart';

abstract class TournamentAction implements ReduxAction {}

@freezed
abstract class UserActionTournament
    with _$UserActionTournament
    implements TournamentAction {
  const factory UserActionTournament.open({
    @required TournamentInfo info,
    @required TournamentStatus status,
  }) = OpenTournamentUserAction;

  const factory UserActionTournament.close() = CloseTournamentUserAction;

  const factory UserActionTournament.load({
    @required TournamentInfo info,
  }) = LoadTournamentUserAction;
}

@freezed
abstract class SystemActionTournament
    with _$SystemActionTournament
    implements TournamentAction {
  const factory SystemActionTournament.init({
    @required TournamentInfo info,
    @required TournamentStatus status,
  }) = InitTournamentSystemAction;

  const factory SystemActionTournament.deInit() = DeInitTournamentSystemAction;

  const factory SystemActionTournament.loading({
    @required TournamentInfo info,
  }) = LoadingTournamentSystemAction;

  const factory SystemActionTournament.failed({
    @required TournamentInfo info,
    @required Exception exception,
  }) = FailedTournamentSystemAction;

  const factory SystemActionTournament.completed({
    @required Tournament tournament,
  }) = CompletedTournamentSystemAction;

  const factory SystemActionTournament.read({
    @required TournamentInfo info,
  }) = ReadTournamentSystemAction;
}
