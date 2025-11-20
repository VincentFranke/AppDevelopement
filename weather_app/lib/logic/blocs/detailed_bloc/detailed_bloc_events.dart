abstract class DetailedBlocEvents {}

class RefreshDataDetailedBlocEvent extends DetailedBlocEvents {
  final String header;
  RefreshDataDetailedBlocEvent({required this.header});
}
