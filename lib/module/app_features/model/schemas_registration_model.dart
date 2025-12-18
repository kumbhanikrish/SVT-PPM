import 'dart:convert';

class SchemasRegistrationModel {
  final int year;
  final List<Schema> schemas;

  SchemasRegistrationModel({required this.year, required this.schemas});

  factory SchemasRegistrationModel.fromRawJson(String str) =>
      SchemasRegistrationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SchemasRegistrationModel.fromJson(Map<String, dynamic> json) =>
      SchemasRegistrationModel(
        year: json["year"],
        schemas: List<Schema>.from(
          json["schemas"].map((x) => Schema.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "year": year,
    "schemas": List<dynamic>.from(schemas.map((x) => x.toJson())),
  };
}

class Schema {
  final int schemaId;
  final String schemaName;
  final dynamic schemaPhoto;
  final int notApprovedCount;
  final List<Item> items;

  Schema({
    required this.schemaId,
    required this.schemaName,
    required this.schemaPhoto,
    required this.notApprovedCount,
    required this.items,
  });

  factory Schema.fromRawJson(String str) => Schema.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
    schemaId: json["schema_id"],
    schemaName: json["schema_name"] ?? '',
    schemaPhoto: json["schema_photo"] ?? '',
    notApprovedCount: json["not_approved_count"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "schema_id": schemaId,
    "schema_name": schemaName,
    "schema_photo": schemaPhoto,
    "not_approved_count": notApprovedCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  final int id;
  final int memberId;
  final String memberName;
  final String memberPhoto;
  final String adminStatus;
  String villagePresidentStatus;
  dynamic remarks;

  Item({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.memberPhoto,
    required this.adminStatus,
    required this.villagePresidentStatus,
    required this.remarks,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    memberId: json["member_id"],
    memberName: json["member_name"],
    memberPhoto: json["member_photo"],
    adminStatus: json["admin_status"],
    villagePresidentStatus: json["village_president_status"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_id": memberId,
    "member_name": memberName,
    "member_photo": memberPhoto,
    "admin_status": adminStatus,
    "village_president_status": villagePresidentStatus,
    "remarks": remarks,
  };
}
