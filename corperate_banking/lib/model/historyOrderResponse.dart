class HistoryOrderResponse {
  String message;
  String accountNumber;
  double amount;
  String dateOfTransferSuccess;
  String bankName;

  HistoryOrderResponse(
      {this.message,
      this.accountNumber,
      this.amount,
      this.dateOfTransferSuccess,
      this.bankName});

  factory HistoryOrderResponse.fromJson(Map<String, dynamic> json) {
    return HistoryOrderResponse(
        message: json['message'],
        accountNumber: json['accountNumber'],
        amount: json['amount'],
        dateOfTransferSuccess: json['dateOfTransferSuccess'],
        bankName: json['bankName']);
  }
}
