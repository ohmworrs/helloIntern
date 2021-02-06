import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'company_user_acct_request.g.dart';

@JsonSerializable()
class CompanyUserAcctRequest extends BaseRequest {

 

  CompanyUserAcctRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory CompanyUserAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$CompanyUserAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyUserAcctRequestToJson(this);
}
