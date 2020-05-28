import 'package:injectable/injectable.dart';
import 'package:what_when_where/data/models/tour.dart';

abstract class ITourCache {
  bool contains(String id);

  void save(Tour tour);

  Tour get(String id);
}

@LazySingleton(as: ITourCache)
class TourCache implements ITourCache {
  final _cache = <String, Tour>{};

  @override
  bool contains(String id) => _cache.containsKey(id);

  @override
  void save(Tour tour) => _cache[tour.id] = tour;

  @override
  Tour get(String id) => _cache[id];
}
