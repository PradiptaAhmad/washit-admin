import 'dart:convert';

/// total_orders : "1"
/// week_number : "3"

MonthlyChartModel monthlyChartModelFromJson(String str) =>
    MonthlyChartModel.fromJson(json.decode(str));
String monthlyChartModelToJson(MonthlyChartModel data) =>
    json.encode(data.toJson());

class MonthlyChartModel {
  MonthlyChartModel({
    String? totalOrders,
    String? weekNumber,
  }) {
    _totalOrders = totalOrders;
    _weekNumber = weekNumber;
  }

  MonthlyChartModel.fromJson(dynamic json) {
    _totalOrders = json['total_orders'];
    _weekNumber = json['week_number'];
  }
  String? _totalOrders;
  String? _weekNumber;
  MonthlyChartModel copyWith({
    String? totalOrders,
    String? weekNumber,
  }) =>
      MonthlyChartModel(
        totalOrders: totalOrders ?? _totalOrders,
        weekNumber: weekNumber ?? _weekNumber,
      );
  String? get totalOrders => _totalOrders;
  String? get weekNumber => _weekNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_orders'] = _totalOrders;
    map['week_number'] = _weekNumber;
    return map;
  }
}
