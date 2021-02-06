// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_add_acct_other_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAddAcctOtherResponse _$CheckAddAcctOtherResponseFromJson(
    Map<String, dynamic> json) {
  return CheckAddAcctOtherResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['bank_Name'] as String,
    json['acct_No'] as String,
    json['acct_Name'] as String,
  );
}

Map<String, dynamic> _$CheckAddAcctOtherResponseToJson(
        CheckAddAcctOtherResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'bank_Name': instance.bank_Name,
      'acct_No': instance.acct_No,
      'acct_Name': instance.acct_Name,
    };
