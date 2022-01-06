class FundHistoryModel {
  final String fundAddHistoryUid;
  final String addedByUid;
  final String addedByUsername;
  final int timestamp;
  final int amount;
  final String paymentMethod;
  final String status;
  final String comment;

  FundHistoryModel({
    required this.fundAddHistoryUid,
    required this.addedByUid,
    required this.addedByUsername,
    required this.timestamp,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.comment,
  });
}
