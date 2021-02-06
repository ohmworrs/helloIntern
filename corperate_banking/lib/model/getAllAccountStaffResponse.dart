
class getAllAccountStaffResponse {
  String bankName;
  String accountNumber;
  String staffFName;
  String staffLName;

  getAllAccountStaffResponse(
      {this.bankName,

      this.accountNumber,
      this.staffFName,
      this.staffLName});

  factory getAllAccountStaffResponse.fromJson(Map<String, dynamic> json) {
    return getAllAccountStaffResponse(
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
