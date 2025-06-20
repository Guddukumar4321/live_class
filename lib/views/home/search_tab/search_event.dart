abstract class SearchEvent {}

class SearchVideosEvent  extends SearchEvent {
  final String query;

  SearchVideosEvent (this.query);
}
