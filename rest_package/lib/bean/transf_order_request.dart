import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'transf_order_request.g.dart';

@JsonSerializable()
class TransfOrderRequest extends BaseRequest {

 

  TransfOrderRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory TransfOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$TransfOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransfOrderRequestToJson(this);
}
