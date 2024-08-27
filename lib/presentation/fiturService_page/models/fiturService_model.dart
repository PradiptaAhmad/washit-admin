class FiturModel {
  int id;
  String name;
  int estimasiWaktu;
  bool isActive;

  FiturModel({
    required this.id,
    required this.name,
    required this.estimasiWaktu,
    required this.isActive,
  });

  factory FiturModel.fromJson(Map<String, dynamic> json) {
    return FiturModel(
      id: json['id'],
      name: json['name'],
      estimasiWaktu: json['estimasi_waktu'],
      isActive: json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'estimasi_waktu': estimasiWaktu,
      'is_active': isActive ? 1 : 0,
    };
  }
}