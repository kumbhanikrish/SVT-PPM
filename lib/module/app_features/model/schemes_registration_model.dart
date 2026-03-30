import 'dart:convert';

class SchemesRegistrationModel {
  final int year;
  final List<Scheme> schemes;

  SchemesRegistrationModel({required this.year, required this.schemes});

  factory SchemesRegistrationModel.fromRawJson(String str) =>
      SchemesRegistrationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SchemesRegistrationModel.fromJson(Map<String, dynamic> json) =>
      SchemesRegistrationModel(
        year: json["year"],
        schemes: List<Scheme>.from(
          json["schemes"].map((x) => Scheme.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "year": year,
    "schemes": List<dynamic>.from(schemes.map((x) => x.toJson())),
  };
}

class Scheme {
  final int schemeId;
  final String schemeName;
  final dynamic schemePhoto;
  final int notApprovedCount;
  final List<Item> items;

  Scheme({
    required this.schemeId,
    required this.schemeName,
    required this.schemePhoto,
    required this.notApprovedCount,
    required this.items,
  });

  factory Scheme.fromRawJson(String str) => Scheme.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
    schemeId: json["scheme_id"],
    schemeName: json["scheme_name"] ?? '',
    schemePhoto: json["scheme_photo"] ?? '',
    notApprovedCount: json["not_approved_count"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "scheme_id": schemeId,
    "scheme_name": schemeName,
    "scheme_photo": schemePhoto,
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
    villagePresidentStatus: json["gam_pratinidhi_status"] ?? '',
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_id": memberId,
    "member_name": memberName,
    "member_photo": memberPhoto,
    "admin_status": adminStatus,
    "gam_pratinidhi_status": villagePresidentStatus,
    "remarks": remarks,
  };
}
