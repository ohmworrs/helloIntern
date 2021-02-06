
class getAllOrderResponse {
  String orderNumber;
  String orderFName;
  String orderLName;
  String date;
  String orderStatus;
  

  getAllOrderResponse(
      {this.orderNumber,
      this.orderFName,
      this.orderLName,
      this.date,
      this.orderStatus
      });

  factory getAllOrderResponse.fromJson(Map<String, dynamic> json) {
    return getAllOrderResponse(
       orderNumber: json['orderNumber'],
        orderFName: json['orderFName'],
        orderLName: json['orderLName'],
        date: json['date'],
        orderStatus: json['orderStatus']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNumber'] = this.orderNumber;
    data['orderFName'] = this.orderFName;
    data['orderLName'] = this.orderLName;
    data['date'] = this.date;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
