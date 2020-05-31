import 'package:injectable/injectable.dart';
import 'package:what_when_where/data/models/tournament.dart';
import 'package:what_when_where/data/status/tournaments_history.dart';

abstract class ITournamentStatusService {
  Future<Tournament> actualize(Tournament tournament);

  Future<Iterable<Tournament>> actualizeAll(Iterable<Tournament> tournaments);
}

@LazySingleton(as: ITournamentStatusService)
class TournamentStatusService implements ITournamentStatusService {
  final ITournamentsHistoryService _historyService;

  const TournamentStatusService({
    ITournamentsHistoryService historyService,
  }) : _historyService = historyService;

  @override
  Future<Tournament> actualize(Tournament tournament) async {
    final wasRead = await _historyService.wasRead(tournament.info);
    return tournament.copyWith.status(isNew: !wasRead);
  }

  @override
  Future<Iterable<Tournament>> actualizeAll(Iterable<Tournament> tournaments) =>
      Future.wait(tournaments.map((x) => actualize(x)));
}