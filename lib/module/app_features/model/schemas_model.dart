class SchemasModel {
  final int id;
  final String title;
  final String template;

  SchemasModel({required this.id, required this.title, required this.template});

  factory SchemasModel.fromJson(Map<String, dynamic> json) => SchemasModel(
    id: json["id"],
    title: json["title"],
    template: json["template"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "template": template,
  };
}
