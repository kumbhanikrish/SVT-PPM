class AppFeatureModel {
  final int? id;
  final String? title;
  final String? image;
  final String? status;
  final bool? applied;
  final String? rejectReason;

  AppFeatureModel({
    this.id,
    this.title,
    this.image,
    this.status,
    this.applied,
    this.rejectReason,
  });

  factory AppFeatureModel.fromJson(Map<String, dynamic> json) {
    return AppFeatureModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      status: json['status'],

      applied: json['is_applied'] == 1 || json['applied'] == true,
      rejectReason: json['reject_reason'],
    );
  }
}
