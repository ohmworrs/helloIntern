// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_favourite_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteFavouriteAcctRequest _$DeleteFavouriteAcctRequestFromJson(
    Map<String, dynamic> json) {
  return DeleteFavouriteAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    last_Name: json['last_Name'] as String,
    acct_No: json['acct_No'] as String,
    first_Name: json['first_Name'] as String,
  );
}

Map<String, dynamic> _$DeleteFavouriteAcctRequestToJson(
        DeleteFavouriteAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'first_Name': instance.first_Name,
      'acct_No': instance.acct_No,
      'last_Name': instance.last_Name,
    };
