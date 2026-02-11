class VillagePresidentModel {
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
  final String address;
  final int isNewMember;
  final dynamic oldMemberId;
  final String oldMemberIdCard;
  final String idProofFront;
  final String idProofBack;
  final int active;
  final String password;
  final int familyHeadId;
  final String relation;
  final String standard;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String name;

  VillagePresidentModel({
    required this.id,
    required this.memberId,
    required this.photo,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
    required this.mobileNo,
    required this.whatsappNo,
    required this.email,
    required this.villageName,
    required this.address,
    required this.isNewMember,
    required this.oldMemberId,
    required this.oldMemberIdCard,
    required this.idProofFront,
    required this.idProofBack,
    required this.active,
    required this.password,
    required this.familyHeadId,
    required this.relation,
    required this.standard,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
  });

  factory VillagePresidentModel.fromJson(Map<String, dynamic> json) =>
      VillagePresidentModel(
        id: json["id"],
        memberId: json["member_id"],
        photo: json["photo"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        mobileNo: json["mobile_no"],
        whatsappNo: json["whatsapp_no"] ?? '',
        email: json["email"],
        villageName: json["village_name"],
        address: json["address"],
        isNewMember: json["is_new_member"],
        oldMemberId: json["old_member_id"],
        oldMemberIdCard: json["old_member_id_card"] ?? '',
        idProofFront: json["id_proof_front"] ?? '',
        idProofBack: json["id_proof_back"] ?? '',
        active: json["active"],
        password: json["password"],
        familyHeadId: json["family_head_id"] ?? 0,
        relation: json["relation"],
        standard: json["standard"] ?? '',
        rememberToken: json["remember_token"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] ?? '',
        name: json["name"],
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
    "family_head_id": familyHeadId,
    "relation": relation,
    "standard": standard,
    "remember_token": rememberToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "name": name,
  };
}
