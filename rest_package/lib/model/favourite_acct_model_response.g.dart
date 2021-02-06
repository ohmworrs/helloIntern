// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_acct_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteAcctModelResponse _$FavouriteAcctModelResponseFromJson(
    Map<String, dynamic> json) {
  return FavouriteAcctModelResponse(
    firstName_Th: json['firstName_Th'] as String,
    lastName_Th: json['lastName_Th'] as String,
    accountNo: json['accountNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$FavouriteAcctModelResponseToJson(
        FavouriteAcctModelResponse instance) =>
    <String, dynamic>{
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'accountNo': instance.accountNo,
      'bankName': instance.bankName,
    };
