class Source {
  Source({
    dynamic id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Source.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  dynamic _id;
  String? _name;

  Source copyWith({
    dynamic id,
    String? name,
  }) =>
      Source(
        id: id ?? _id,
        name: name ?? _name,
      );

  dynamic get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
