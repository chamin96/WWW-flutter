import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/tours/state.dart';
import 'package:what_when_where/ui/tour_details/data_tile.dart';
import 'package:what_when_where/ui/tour_details/error_tile.dart';
import 'package:what_when_where/ui/tour_details/loading_tile.dart';

class TourDetailsRouteTile extends StatelessWidget {
  const TourDetailsRouteTile({
    Key key,
    this.tourId,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  final String tourId;

  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, TourState>(
        distinct: true,
        converter: (store) => store.state.toursState.tours
            .firstWhere((tourState) => tourState.info.id == tourId),
        builder: (context, state) {
          if (state is LoadingTourState) {
            return TourDetailsLoadingTile(
              tourInfo: state.info,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
            );
          }

          if (state is ErrorTourState) {
            return TourDetailsErrorTile(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              tourInfo: state.info,
              exception: state.exception,
            );
          }

          if (state is DataTourState) {
            return TourDetailsDataTile(
              tour: state.tour,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
            );
          }

          return Container();
        },
      );
}
