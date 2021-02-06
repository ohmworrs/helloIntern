class getAllAccountOtherCompanyRequest {
  String keyword;

  getAllAccountOtherCompanyRequest({this.keyword});

  getAllAccountOtherCompanyRequest.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    return data;
  }
}
