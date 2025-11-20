import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/blocs/detailed_bloc/detailed_bloc.dart';
import 'package:weather_app/logic/blocs/detailed_bloc/detailed_bloc_events.dart';
import 'package:weather_app/logic/blocs/detailed_bloc/detailed_bloc_states.dart';
import 'package:weather_app/ui/line_chart_temp.dart';
import 'package:weather_app/ui/reusable/shimmer_wrapper.dart';

class DetailedDayForecastScreen extends StatelessWidget {
  final String header;
  const DetailedDayForecastScreen({super.key, required this.header});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailedBloc()..add(RefreshDataDetailedBlocEvent(header: header)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${AppLocalizations.of(context)!.dayForecast} $header'),
        ),
        body: Builder(
          builder: (context) {
            final detailedBloc = context.watch<DetailedBloc>();
            final detailedBlocState = detailedBloc
                .state; // Muss ich speichern damit ich mir keine zwei Instanzen hole
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ShimmerWrapper(
                      applyShimmer:
                          detailedBlocState is LoadingDetailedBlocState,
                      skeleton: (child) {
                        return SizedBox.expand(
                          child: ColoredBox(color: Colors.grey, child: child),
                        );
                      },
                      childToShowWhenNoShimmer:
                          detailedBlocState is ShowDataDetailedBlocState
                          ? LinechartTemp(
                              hourlyForecastEntityList:
                                  detailedBlocState.hourlyForecastEntityList,
                            )
                          : null,
                    ),
                  ),
                  Expanded(child: Placeholder()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
