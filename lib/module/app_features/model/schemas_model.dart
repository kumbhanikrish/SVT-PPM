class SchemasModel {
  final int id;
  final String title;
  final String template;
  bool isApplied;

  SchemasModel({
    required this.id,
    required this.title,
    required this.template,
    required this.isApplied,
  });

  factory SchemasModel.fromJson(Map<String, dynamic> json) => SchemasModel(
    id: json["id"],
    title: json["title"],
    template: json["template"],
    isApplied: json["is_applied"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "template": template,
    "is_applied": isApplied,
  };
}
