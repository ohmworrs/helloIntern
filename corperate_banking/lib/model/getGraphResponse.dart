class getGraphResponse {
  String accountType;
  double ledgerBalance;

  getGraphResponse(
      {this.accountType,
      this.ledgerBalance});

  factory getGraphResponse.fromJson(Map<String, dynamic> json) {
    return getGraphResponse(
        accountType: json['accountType'],
   
        ledgerBalance: json['ledgerBalance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountType'] = this.accountType;
    data['ledgerBalance'] = this.ledgerBalance;
    return data;
  }
}