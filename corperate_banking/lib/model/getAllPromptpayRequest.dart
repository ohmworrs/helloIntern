class getAllPromptpayRequest {
  String keyword;

  getAllPromptpayRequest({this.keyword});

  getAllPromptpayRequest.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    return data;
  }
}
