class SettingModel {
  int id;
  String username;
  String email;
  String phone;
  String imagePath;
  dynamic phoneVerifiedAt;
  dynamic emailVerifiedAt;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  SettingModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.phoneVerifiedAt,
    required this.emailVerifiedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    imagePath: json["image_path"],
    phoneVerifiedAt: json["phone_verified_at"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "image_path": imagePath,
    "phone_verified_at": phoneVerifiedAt,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
