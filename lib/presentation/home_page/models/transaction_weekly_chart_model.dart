class TransactionWeeklyChartModel {
  int? totalTransactions;
  int? totalIncome;
  String? createdAt;

  TransactionWeeklyChartModel({
    this.totalTransactions,
    this.totalIncome,
    this.createdAt,
  });

  TransactionWeeklyChartModel.fromJson(dynamic json) {
    totalTransactions = json['total_transactions'];
    totalIncome = json['total_income'];
    createdAt = json['created_at'];
  }

  TransactionWeeklyChartModel copyWith({
    int? totalTransactions,
    int? totalIncome,
    String? createdAt,
  }) =>
      TransactionWeeklyChartModel(
        totalTransactions: totalTransactions ?? this.totalTransactions,
        totalIncome: totalIncome ?? this.totalIncome,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_transactions'] = totalTransactions;
    map['total_income'] = totalIncome;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  String toString() {
    return 'TransactionChartModel(totalTransactions: $totalTransactions, totalIncome: $totalIncome, createdAt: $createdAt)';
  }
}
