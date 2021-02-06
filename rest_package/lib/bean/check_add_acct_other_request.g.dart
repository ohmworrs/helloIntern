// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_add_acct_other_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAddAcctOtherRequest _$CheckAddAcctOtherRequestFromJson(
    Map<String, dynamic> json) {
  return CheckAddAcctOtherRequest(
    reqRefNo: json['reqRefNo'] as String,
    bank_Name: json['bank_Name'] as String,
    acct_No: json['acct_No'] as String,
  );
}

Map<String, dynamic> _$CheckAddAcctOtherRequestToJson(
        CheckAddAcctOtherRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'bank_Name': instance.bank_Name,
      'acct_No': instance.acct_No,
    };
