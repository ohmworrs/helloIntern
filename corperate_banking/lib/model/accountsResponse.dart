
class AccountsResponse {
  String bankName;
  String accountType;
  String accountNumber;
  double availableBalance;
  double ledgerBalance;

  AccountsResponse(
      {this.bankName,
      this.accountType,
      this.accountNumber,
      this.availableBalance,
      this.ledgerBalance});

  factory AccountsResponse.fromJson(Map<String, dynamic> json) {
    return AccountsResponse(
        bankName: json['bankName'],
        accountType: json['accountType'],
        accountNumber: json['accountNumber'],
        availableBalance: json['availableBalance'],
        ledgerBalance: json['ledgerBalance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['accountType'] = this.accountType;
    data['accountNumber'] = this.accountNumber;
    data['availableBalance'] = this.availableBalance;
    data['ledgerBalance'] = this.ledgerBalance;
    return data;
  }
}
