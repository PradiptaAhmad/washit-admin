class FiturModel {
  int id;
  String name;

  FiturModel({required this.id, required this.name});

  factory FiturModel.fromJson(Map<String, dynamic> json) {
    return FiturModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
