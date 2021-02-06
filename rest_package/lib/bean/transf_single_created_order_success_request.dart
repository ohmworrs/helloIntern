import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'transf_single_created_order_success_request.g.dart';

@JsonSerializable()
class TransfSingleCreatedOrderSuccessRequest extends BaseRequest {
  final String sender_Account_No;
  final String sender_account_No_name;
  final String bank_Name_Sender;
  final String sender_Account_Type;
  final String bank_Name_Recipient;
  final String recipient_account_No;
  final String recipient_account_No_name_Th;
  final String recipient_account_No_name_En;
  final double transAmount;
  final String note;
  final double fee;
  final String trnfType;
  final String recipient_Account_Type;

  
  TransfSingleCreatedOrderSuccessRequest({
    this.sender_Account_No,
    this.sender_account_No_name,
    this.bank_Name_Sender,
    this.sender_Account_Type,
    this.bank_Name_Recipient,
    this.recipient_account_No,
    this.recipient_account_No_name_Th,
    this.recipient_account_No_name_En,
    this.transAmount,
    this.note,
    this.fee,
    this.recipient_Account_Type,
    this.trnfType,
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory TransfSingleCreatedOrderSuccessRequest.fromJson(Map<String, dynamic> json) =>
      _$TransfSingleCreatedOrderSuccessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransfSingleCreatedOrderSuccessRequestToJson(this);
}
