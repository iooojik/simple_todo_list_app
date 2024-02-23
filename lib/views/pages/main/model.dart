class Model {
  final String name;

  Model({this.name = ""});

  Model copyWith({
    String? name,
  }) {
    return Model(
      name: name ?? this.name,
    );
  }
}
