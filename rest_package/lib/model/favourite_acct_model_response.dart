import 'package:json_annotation/json_annotation.dart';


part 'favourite_acct_model_response.g.dart';

@JsonSerializable()
class FavouriteAcctModelResponse {
  final String firstName_Th;
  final String lastName_Th;
  final String accountNo;
  final String bankName;
  

  FavouriteAcctModelResponse({
    this.firstName_Th,
    this.lastName_Th,
    this.accountNo,
    this.bankName
    
  });

   factory FavouriteAcctModelResponse.fromJson(Map<String, dynamic> json) => _$FavouriteAcctModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteAcctModelResponseToJson(this);
}
