// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favourite_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavouriteAcctRequest _$AddFavouriteAcctRequestFromJson(
    Map<String, dynamic> json) {
  return AddFavouriteAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    firstName_Th: json['firstName_Th'] as String,
    lastName_Th: json['lastName_Th'] as String,
    acct_No: json['acct_No'] as String,
  );
}

Map<String, dynamic> _$AddFavouriteAcctRequestToJson(
        AddFavouriteAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'acct_No': instance.acct_No,
    };
