// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUserAcctResponse _$CompanyUserAcctResponseFromJson(
    Map<String, dynamic> json) {
  return CompanyUserAcctResponse(
    firstName_Th: json['firstName_Th'] as String,
    lastName_Th: json['lastName_Th'] as String,
    accountNo: json['accountNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$CompanyUserAcctResponseToJson(
        CompanyUserAcctResponse instance) =>
    <String, dynamic>{
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'accountNo': instance.accountNo,
      'bankName': instance.bankName,
    };
