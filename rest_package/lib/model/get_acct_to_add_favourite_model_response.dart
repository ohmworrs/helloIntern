import 'package:json_annotation/json_annotation.dart';


part 'get_acct_to_add_favourite_model_response.g.dart';

@JsonSerializable()
class GetAcctToAddFavouriteModelResponse {
  final String firstName_Th;
  final String lastName_Th;
  final String accountNo;
  final String bankName;
  

  GetAcctToAddFavouriteModelResponse({
    this.firstName_Th,
    this.lastName_Th,
    this.accountNo,
    this.bankName
    
  });

   factory GetAcctToAddFavouriteModelResponse.fromJson(Map<String, dynamic> json) => _$GetAcctToAddFavouriteModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcctToAddFavouriteModelResponseToJson(this);
}
