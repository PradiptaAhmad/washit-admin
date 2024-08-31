class OverviewModel {
  String status;
  String message;
  int totalOrders;
  int totalUsers;
  int totalTransactions;
  double averageRatings;

  OverviewModel({
    required this.status,
    required this.message,
    required this.totalOrders,
    required this.totalUsers,
    required this.totalTransactions,
    required this.averageRatings,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) => OverviewModel(
    status: json["status"],
    message: json["message"],
    totalOrders: json["total_orders"],
    totalUsers: json["total_users"],
    totalTransactions: json["total_transactions"],
    averageRatings: json["average_ratings"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total_orders": totalOrders,
    "total_users": totalUsers,
    "total_transactions": totalTransactions,
    "average_ratings": averageRatings,
  };
}
