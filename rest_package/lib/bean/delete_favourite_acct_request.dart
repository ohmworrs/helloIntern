import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'delete_favourite_acct_request.g.dart';

@JsonSerializable()
class DeleteFavouriteAcctRequest extends BaseRequest {
  final String first_Name;
  final String acct_No;
  final String last_Name;

 

  DeleteFavouriteAcctRequest({
    String reqRefNo,
    this.last_Name,
    this.acct_No,
    this.first_Name
   
  }) : super(reqRefNo);

  factory DeleteFavouriteAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavouriteAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFavouriteAcctRequestToJson(this);
}
