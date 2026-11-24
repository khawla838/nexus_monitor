class ServerModel {
  final int id;
  final String name;
  final String description;

  ServerModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}