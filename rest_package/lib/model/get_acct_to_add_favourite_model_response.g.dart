// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_acct_to_add_favourite_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcctToAddFavouriteModelResponse _$GetAcctToAddFavouriteModelResponseFromJson(
    Map<String, dynamic> json) {
  return GetAcctToAddFavouriteModelResponse(
    firstName_Th: json['firstName_Th'] as String,
    lastName_Th: json['lastName_Th'] as String,
    accountNo: json['accountNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$GetAcctToAddFavouriteModelResponseToJson(
        GetAcctToAddFavouriteModelResponse instance) =>
    <String, dynamic>{
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'accountNo': instance.accountNo,
      'bankName': instance.bankName,
    };
