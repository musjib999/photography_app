class MediaAnalyticsModel {
  final int totalAmountPaid;
  final int totalQuantity;
  final int pendingBalance;
  MediaAnalyticsModel(
      {required this.totalAmountPaid,
      required this.totalQuantity,
      required this.pendingBalance});
}

class ItemAnalyticsModel {
  final int totalAmountPaid;
  final int totalQuantity;
  final int pendingBalance;
  ItemAnalyticsModel({
    required this.totalAmountPaid,
    required this.totalQuantity,
    required this.pendingBalance,
  });
}

class ConnectionAnalyticsModel {
  final int totalAmountPaid;
  final int totalQuantity;

  ConnectionAnalyticsModel(
      {required this.totalAmountPaid, required this.totalQuantity});
}

class AnalyticsModel {
  final int monthlyTotalAmountPaid;
  final int monthlyTotalPendingBalance;
  final int monthlyTotalQuantity;
  final int monthlyTotalExpense;

  AnalyticsModel(
      {required this.monthlyTotalAmountPaid,
      required this.monthlyTotalExpense,
      required this.monthlyTotalPendingBalance,
      required this.monthlyTotalQuantity});
}
