import 'package:json_annotation/json_annotation.dart';


part 'company_user_acct_response.g.dart';

@JsonSerializable()
class CompanyUserAcctResponse {
  final String firstName_Th;
  final String lastName_Th;
  final String accountNo;
  final String bankName;

  CompanyUserAcctResponse({
    this.firstName_Th,
    this.lastName_Th,
    this.accountNo,
    this.bankName
  });

   factory CompanyUserAcctResponse.fromJson(Map<String, dynamic> json) => _$CompanyUserAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyUserAcctResponseToJson(this);
}
