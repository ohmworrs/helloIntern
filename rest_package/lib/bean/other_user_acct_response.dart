import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/other_user_acct_model_response.dart';

part 'other_user_acct_response.g.dart';

@JsonSerializable()
class OtherUserAcctResponse extends BaseResponse{
  List<OtherUserAcctModelResponse> otherUserAcctList;

  OtherUserAcctResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.otherUserAcctList,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory OtherUserAcctResponse.fromJson(Map<String, dynamic> json) => _$OtherUserAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserAcctResponseToJson(this);

}