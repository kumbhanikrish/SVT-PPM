class LoginModel {
  final int id;
  final String memberId;
  final String photo;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final String mobileNo;
  final String whatsappNo;
  final String email;
  final String villageName;
  final String villageCode;
  final String address;
  final dynamic isNewMember;
  final dynamic oldMemberId;
  final dynamic oldMemberIdCard;
  final String idProofFront;
  final String idProofBack;
  final int active;
  final String password;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String token;
  final String name;
  final String relation;
  final String memberFamilyCard;
  final String standard;
  final int familyHeadId;
  final List<Role> roles;

  LoginModel({
    required this.id,
    required this.memberId,
    required this.photo,
    required this.memberFamilyCard,
    required this.villageCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.mobileNo,
    required this.whatsappNo,
    required this.relation,
    required this.standard,
    required this.email,
    required this.villageName,
    required this.address,
    required this.isNewMember,
    required this.oldMemberId,
    required this.oldMemberIdCard,
    required this.idProofFront,
    required this.familyHeadId,
    required this.idProofBack,
    required this.active,
    required this.password,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.token,
    required this.name,
    required this.roles,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    memberId: json["member_id"],
    photo: json["photo"],
    firstName: json["first_name"],
    familyHeadId: json["family_head_id"] ?? 0,
    middleName: json["middle_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    relation: json["relation"] ?? '',
    standard: json["standard"] ?? '',
    memberFamilyCard: json["memberFamilyCard"] ?? '',
    mobileNo: json["mobile_no"],
    whatsappNo: json["whatsapp_no"] ?? '',
    email: json["email"],
    villageName: json["village_name"],
    villageCode: json["village_code"] ?? '',
    address: json["address"],
    isNewMember: json["is_new_member"],
    oldMemberId: json["old_member_id"],
    oldMemberIdCard: json["old_member_id_card"] ?? '',
    idProofFront: json["id_proof_front"] ?? '',
    idProofBack: json["id_proof_back"] ?? '',
    active: json["active"],
    password: json["password"],
    rememberToken: json["remember_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    token: json["token"] ?? '',
    name: json["name"],
    roles:
        json["roles"] == null
            ? []
            : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_id": memberId,
    "photo": photo,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "gender": gender,
    "mobile_no": mobileNo,
    "memberFamilyCard": memberFamilyCard,
    "whatsapp_no": whatsappNo,
    "email": email,
    "village_name": villageName,
    "address": address,
    "is_new_member": isNewMember,
    "old_member_id": oldMemberId,
    "old_member_id_card": oldMemberIdCard,
    "id_proof_front": idProofFront,
    "id_proof_back": idProofBack,
    "active": active,
    "password": password,
    "standard": standard,
    "relation": relation,
    "remember_token": rememberToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "token": token,
    "name": name,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };

  bool hasRole(int roleId) {
    return roles.any((role) => role.id == roleId);
  }

  bool hasAnyRole(List<int> roleIds) {
    return roles.any((role) => roleIds.contains(role.id));
  }
}

class Role {
  final int id;
  final String name;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final int modelId;
  final int roleId;
  final String modelType;

  Pivot({required this.modelId, required this.roleId, required this.modelType});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"],
    roleId: json["role_id"],
    modelType: json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "role_id": roleId,
    "model_type": modelType,
  };
}
