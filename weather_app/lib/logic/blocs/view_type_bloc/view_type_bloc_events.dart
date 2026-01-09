import 'package:weather_app/logic/view_type.dart';

abstract class ViewTypeBlocEvents {}

class ViewTypeChangedEvent extends ViewTypeBlocEvents {
  final ViewType newViewType;
  ViewTypeChangedEvent({required this.newViewType});
}
