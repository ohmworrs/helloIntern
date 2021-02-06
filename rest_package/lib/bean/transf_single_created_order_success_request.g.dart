// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_single_created_order_success_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfSingleCreatedOrderSuccessRequest
    _$TransfSingleCreatedOrderSuccessRequestFromJson(
        Map<String, dynamic> json) {
  return TransfSingleCreatedOrderSuccessRequest(
    sender_Account_No: json['sender_Account_No'] as String,
    sender_account_No_name: json['sender_account_No_name'] as String,
    bank_Name_Sender: json['bank_Name_Sender'] as String,
    sender_Account_Type: json['sender_Account_Type'] as String,
    bank_Name_Recipient: json['bank_Name_Recipient'] as String,
    recipient_account_No: json['recipient_account_No'] as String,
    recipient_account_No_name_Th:
        json['recipient_account_No_name_Th'] as String,
    recipient_account_No_name_En:
        json['recipient_account_No_name_En'] as String,
    transAmount: (json['transAmount'] as num)?.toDouble(),
    note: json['note'] as String,
    fee: (json['fee'] as num)?.toDouble(),
    recipient_Account_Type: json['recipient_Account_Type'] as String,
    trnfType: json['trnfType'] as String,
    reqRefNo: json['reqRefNo'] as String,
  );
}

Map<String, dynamic> _$TransfSingleCreatedOrderSuccessRequestToJson(
        TransfSingleCreatedOrderSuccessRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'sender_Account_No': instance.sender_Account_No,
      'sender_account_No_name': instance.sender_account_No_name,
      'bank_Name_Sender': instance.bank_Name_Sender,
      'sender_Account_Type': instance.sender_Account_Type,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'transAmount': instance.transAmount,
      'note': instance.note,
      'fee': instance.fee,
      'trnfType': instance.trnfType,
      'recipient_Account_Type': instance.recipient_Account_Type,
    };
