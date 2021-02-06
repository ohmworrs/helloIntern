import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'add_favourite_acct_request.g.dart';

@JsonSerializable()
class AddFavouriteAcctRequest extends BaseRequest {
  final String firstName_Th;
  final String lastName_Th;
  final String acct_No;
 

  AddFavouriteAcctRequest({
    String reqRefNo,
    this.firstName_Th,
    this.lastName_Th,
    this.acct_No,
  }) : super(reqRefNo);

  factory AddFavouriteAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavouriteAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavouriteAcctRequestToJson(this);
}
