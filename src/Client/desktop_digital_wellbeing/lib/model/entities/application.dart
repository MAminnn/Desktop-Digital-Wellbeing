class Application {
  String id;
  String path;

  Application({required this.path, required this.id});

  factory Application.fromQuery(Map<String, Object?> query) {
    return Application(
        id: query['ID'] as String, path: query['Path'] as String);
  }
}
