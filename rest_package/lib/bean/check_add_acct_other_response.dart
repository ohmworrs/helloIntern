import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'check_add_acct_other_response.g.dart';

@JsonSerializable()
class CheckAddAcctOtherResponse extends BaseResponse{

  final String bank_Name;
  final String acct_No;
  final String acct_Name;
  

 CheckAddAcctOtherResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.bank_Name,
      this.acct_No,
      this.acct_Name,) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckAddAcctOtherResponse.fromJson(Map<String, dynamic> json) => _$CheckAddAcctOtherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAddAcctOtherResponseToJson(this);

}