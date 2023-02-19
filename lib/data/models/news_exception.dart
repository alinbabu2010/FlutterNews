class NewsException implements Exception {
  final String? _message;

  NewsException(this._message);

  @override
  String toString() {
    return _message ?? "Exception occurred";
  }
}
