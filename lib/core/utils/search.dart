extension SearchExtension<T> on Iterable<T> {
  List<T> search({
    required String query,
    required String Function(T item) selector,
    bool caseSensitive = false,
  }) {
    final searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      return toList();
    }

    return where((item) {
      final value = selector(item);

      if (caseSensitive) {
        return value.contains(searchQuery);
      }

      return value.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
}
