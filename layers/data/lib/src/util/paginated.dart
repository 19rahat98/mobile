class Paginated<T> {
  const Paginated(
    this.values, {
    required this.pageToken,
    required this.canFetchMore,
  });

  final List<T> values;
  final String? pageToken;
  final bool canFetchMore;
}
