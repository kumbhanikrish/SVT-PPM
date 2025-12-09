import 'package:animated_custom_dropdown/custom_dropdown.dart';

class VillageModel with CustomDropdownListFilter {
  final int id;
  final String name;
  final String key;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  VillageModel({
    required this.id,
    required this.name,
    required this.key,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) => VillageModel(
    id: json["id"],
    name: json["name"],
    key: json["key"],
    code: json["code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  @override
  String toString() => '$name - $key';

  @override
  bool filter(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        key.toLowerCase().contains(lowerQuery);
  }
}
