import 'dart:convert';

class SchemasModel {
  final int id;
  final String title;
  final String template;
  final String pdfTemplate;
  final String photo;
  bool isApplied;
  final String status;
  final String remarks;
  final String year;
  final bool canReapply;
  final List<Document> documents;

  SchemasModel({
    required this.id,
    required this.title,
    required this.template,
    required this.photo,
    required this.isApplied,
    required this.status,
    required this.remarks,
    required this.year,
    required this.canReapply,
    required this.documents,
    required this.pdfTemplate,
  });

  factory SchemasModel.fromRawJson(String str) =>
      SchemasModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SchemasModel.fromJson(Map<String, dynamic> json) => SchemasModel(
    id: json["id"],
    title: json["title"],
    template: json["template"],
    photo: json["photo"] ?? '',
    isApplied: json["is_applied"],
    status: json["status"] ?? '',
    remarks: json["remarks"] ?? '',
    year: json["year"] ?? '',
    canReapply: json["can_reapply"],
    pdfTemplate: json["pdf_template"] ?? '',
    documents: List<Document>.from(
      json["documents"].map((x) => Document.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "template": template,
    "photo": photo,
    "is_applied": isApplied,
    "status": status,
    "remarks": remarks,
    "year": year,
    "can_reapply": canReapply,
    "pdf_template": pdfTemplate,
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class Document {
  final String name;
  final String key;
  final bool isRequired;

  Document({required this.name, required this.key, required this.isRequired});

  factory Document.fromRawJson(String str) =>
      Document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    name: json["name"],
    key: json["key"],
    isRequired: json["is_required"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "is_required": isRequired,
  };
}
