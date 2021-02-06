
class getAllAccountOtherCompanyResponse {
  String bankName;
  String accountNumber;
  String staffFName;
  String staffLName;

  getAllAccountOtherCompanyResponse(
      {this.bankName,
      this.accountNumber,
      this.staffFName,
      this.staffLName});

  factory getAllAccountOtherCompanyResponse.fromJson(Map<String, dynamic> json) {
    return getAllAccountOtherCompanyResponse(
        bankName: json['bankName'],
        accountNumber: json['accountNumber'],
        staffFName: json['staffFName'],
        staffLName: json['staffLName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['staffFName'] = this.staffFName;
    data['staffLName'] = this.staffLName;
    return data;
  }
}
