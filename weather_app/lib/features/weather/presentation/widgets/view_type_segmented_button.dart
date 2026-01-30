import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_state.dart';
import 'package:weather_app/core/enums/view_type.dart';

class ViewTypeSegmentedButton extends StatelessWidget {
  final ViewTypeBloc viewTypeBloc;
  final CurrentInputBloc currentInputBloc;
  const ViewTypeSegmentedButton({
    super.key,
    required this.viewTypeBloc,
    required this.currentInputBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewTypeBloc,
      child: BlocBuilder<ViewTypeBloc, ViewTypeState>(
        builder: (context, _) => SegmentedButton(
          segments: [
            ButtonSegment(
              value: ViewType.dayView,
              label: Text(AppLocalizations.of(context)!.dayView),
            ),
            ButtonSegment(
              value: ViewType.weekView,
              label: Text(AppLocalizations.of(context)!.weekView),
            ),
          ],
          selected: {viewTypeBloc.state.viewType},
          onSelectionChanged: (newViewType) {
            viewTypeBloc.add(ViewTypeChanged(newViewType: newViewType.first));
            currentInputBloc.add(
              CurrentInputChangedEvent.CurrentInputChanged(
                currentInput: currentInputBloc.state.currentInput,
                viewType: newViewType.first,
              ),
            );
            // Test
          },
        ),
      ),
    );
  }
}
