class orderChartModel {
  String? totalOrders;
  String? createdAt;

  orderChartModel({
    this.totalOrders,
    this.createdAt,
  });

  orderChartModel.fromJson(dynamic json) {
    totalOrders = json['total_orders'];
    createdAt = json['created_at'];
  }

  orderChartModel copyWith({
    String? totalOrders,
    String? createdAt,
  }) =>
      orderChartModel(
        totalOrders: totalOrders ?? this.totalOrders,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_orders'] = totalOrders;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  String toString() {
    return 'ChartModel(totalOrders: $totalOrders, createdAt: $createdAt)';
  }
}
