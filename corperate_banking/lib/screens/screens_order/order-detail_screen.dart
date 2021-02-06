import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/transf_order_detail_request.dart';
import 'package:rest_package/bean/transf_order_detail_response.dart';
import 'package:rest_package/connection/transf_order_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/transf_order_detail_model_response.dart';

class OrderDetailScreen extends StatefulWidget {
  String tracNo;
  OrderDetailScreen({this.tracNo});
  @override
  _OrderDetailScreenState createState() =>
      _OrderDetailScreenState(tracNo: tracNo);
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  String tracNo;
  _OrderDetailScreenState({this.tracNo});
  TransfOrderDetailConnection transfOrderDetailConnect =
      TransfOrderDetailConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  checkLogoBank(String bankName) {
    switch (bankName) {
      case "ไทยพาณิชย์":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "กรุงเทพ":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "กรุงไทย":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "กรุงศรีอยุธยา":
        return AssetImage('assests/images/BAY.png');
        break;
      case "กสิกรไทย":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "ทหารไทย":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "ธนชาติ ":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "อาคารสงเคราะห์":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "ออมสิน":
        return AssetImage('assests/images/GSB-logo.jpg');
        break;

      default:
        return null;
    }
  }

  checkNameBankFromLogo(String bankName) {
    switch (bankName) {
      case "ไทยพาณิชย์":
        return "ธนาคารไทยพาณิชย์";
        break;
      case "กรุงเทพ":
        return "ธนาคารกรุงเทพ";
        break;
      case "กรุงไทย":
        return "ธนาคารกรุงไทย";
        break;
      case "กรุงศรีอยุธยา":
        return "ธนาคารกรุงศรีอยุธยา";
        break;
      case "กสิกรไทย":
        return "ธนาคารกสิกรไทย";
        break;
      case "ทหารไทย":
        return "ธนาคารทหารไทย";
        break;
      case "ธนชาติ":
        return "ธนาคารธนชาต";
        break;
      case "อาคารสงเคราะห์":
        return "ธนาคารอาคารสงเคราะห์";
        break;
      case "ออมสิน":
        return "ธนาคารออมสิน";
        break;

      default:
        return "null";
    }
  }

  Future<TransfOrderDetailModelResponse> getOrderDetail() async {
    TransfOrderDetailModelResponse res = new TransfOrderDetailModelResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderDetail: ' + reqRefNo);
    TransfOrderDetailRequest request =
        TransfOrderDetailRequest(reqRefNo: reqRefNo, traceNo: tracNo);
    await transfOrderDetailConnect
        .transfOrderDetailConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderDetailResponse response =
            TransfOrderDetailResponse.fromJson(responseMap);
        print("respDescCodeGetOrderDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.dateTime = response.dateTime;
          res.fee = response.fee;
          res.note = response.note;
          res.recipient_account_No = response.recipient_account_No;
          res.recipient_account_No_name_En =
              response.recipient_account_No_name_En;
          res.recipient_account_No_name_Th =
              response.recipient_account_No_name_Th;
          res.sender_Account_No = response.sender_Account_No;
          res.sender_Account_Type = response.sender_Account_Type;
          res.traceNo = response.traceNo;
          res.trnStatus = response.trnStatus;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.bank_Name_Sender = response.bank_Name_Sender;
          res.amount = response.amount;
        }
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFCFCFCF),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.pink[300],
          centerTitle: true,
          title: Text(
            'รายการตรวจสอบ',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Stack(
          children: [
            _buildBackgroundImageBlur(context),
            ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.01,
                      ),
                      FutureBuilder<TransfOrderDetailModelResponse>(
                        future: getOrderDetail(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var data = snapshot.data;
                            var str = data.trnStatus;
                            return Stack(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(
                                      left: _height * 0.02, right: _height * 0.02),
                                  width: _width,
                                  height: _height * 0.65,
                                  child: ClipPath(
                                    clipper: PointsClipper(),
                                    child: Container(
                                      height: _height * 0.1,
                                      width: _width,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: _height * 0.05,
                                    ),
                                    Container(
                                      width: _width,
                                      height: _height * 0.9,
                                      // color: Colors.green,
                                      padding: EdgeInsets.only(
                                          left: _height * 0.02,
                                          right: _height * 0.02),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: _width,
                                            height: _height * 0.55,
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: _height * 0.05,
                                                ),
                                                Container(
                                                  width: _width,
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: _height * 0.01,
                                                      ),
                                                      Container(
                                                        height: _height * 0.045,
                                                        width: _width,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          'รายการการโอน',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  _height * 0.04,
                                                              fontWeight:
                                                                  FontWeight.w300),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: _height * 0.03,
                                                        width: _width,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Text(
                                                          data.dateTime,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  _height * 0.023,
                                                              color: Colors.grey),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: _height * 0.01,
                                                      ),
                                                      Container(
                                                        width: _width,
                                                        height: _height * 0.17,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                left:
                                                                    _height * 0.02,
                                                              ),
                                                              width: _width,
                                                              height:
                                                                  _height * 0.075,
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                      'จาก',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              _height *
                                                                                  0.023),
                                                                    ),
                                                                    width: _width *
                                                                        0.1,
                                                                    height: _height,
                                                                    alignment: Alignment
                                                                        .centerLeft,
                                                                  ),
                                                                  Container(
                                                                    width: _width *
                                                                        0.15,
                                                                    height: _height,
                                                                    alignment: Alignment
                                                                        .centerLeft,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundImage:
                                                                          checkLogoBank(
                                                                              data.bank_Name_Sender),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow,
                                                                      radius:
                                                                          _height *
                                                                              0.03,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: _width *
                                                                        0.55,
                                                                    height: _height,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          height:
                                                                              _height *
                                                                                  0.01,
                                                                        ),
                                                                        Text(
                                                                          data.sender_Account_Type,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  _height * 0.018),
                                                                        ),
                                                                        Text(
                                                                          data.sender_Account_No,
                                                                          style: TextStyle(
                                                                              fontSize: _height *
                                                                                  0.015,
                                                                              color:
                                                                                  Colors.grey),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: _width,
                                                              height:
                                                                  _height * 0.09,
                                                              padding:
                                                                  EdgeInsets.only(
                                                                left:
                                                                    _height * 0.02,
                                                              ),
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                      'ถึง',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              _height *
                                                                                  0.023),
                                                                    ),
                                                                    width: _width *
                                                                        0.1,
                                                                    height: _height,
                                                                    alignment: Alignment
                                                                        .centerLeft,
                                                                  ),
                                                                  Container(
                                                                    width: _width *
                                                                        0.15,
                                                                    height: _height,
                                                                    alignment: Alignment
                                                                        .centerLeft,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundImage:
                                                                          checkLogoBank(
                                                                              data.bank_Name_Recipient),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow,
                                                                      radius:
                                                                          _height *
                                                                              0.03,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: _width *
                                                                        0.55,
                                                                    height: _height,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          height:
                                                                              _height *
                                                                                  0.01,
                                                                        ),
                                                                        Text(
                                                                          data.recipient_account_No_name_Th,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  _height * 0.018),
                                                                        ),
                                                                        Text(
                                                                          data.recipient_account_No,
                                                                          style: TextStyle(
                                                                              fontSize: _height *
                                                                                  0.015,
                                                                              color:
                                                                                  Colors.grey),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                          left: _height * 0.02,
                                                          right: _height * 0.02,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'เลขที่รายการ :',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.023),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                data.traceNo,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.03),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                          left: _height * 0.02,
                                                          right: _height * 0.02,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'จำนวนเงิน :',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.023),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '${formatMoney.format(data.amount)}' +
                                                                    ' บาท',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.03),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                          left: _height * 0.02,
                                                          right: _height * 0.02,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'ค่าธรรมเนียม :',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.023),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '${formatMoney.format(data.fee)}' +
                                                                    ' บาท',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.03),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                          left: _height * 0.02,
                                                          right: _height * 0.02,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'บันทึก :',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.023),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                data.note,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.018),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        color: Colors.white,
                                                        padding: EdgeInsets.only(
                                                            left: _height * 0.02,
                                                            right: _height * 0.02),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                'สถานะการทำรายการ :',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.023),
                                                              ),
                                                            ),
                                                            Container(
                                                                child:
                                                                    _buildTextStatus(
                                                                        _height,
                                                                        str))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            width: _width,
                                            height: _height * 0.085,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: _height * 0.1,
                                  width: _width,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: _height * 0.1,
                                      width: _width * 0.2,
                                      child: _buildIconHead(_height, str)),
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextStatus(double _height, String str) {
    switch (str) {
      case "Approved":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.green),
        );
        break;
        case "Waiting for Check":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.yellow),
        );
        break;
        case "Waiting for Approval":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.orange),
        );
        break;
        case "Cancle By Maker":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.red),
        );
        break;
        case "Cancle By Checker":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.red),
        );
        break;
        case "Cancle By Authorizer":
        return Text(
          str,
          style: TextStyle(fontSize: _height * 0.03, color: Colors.red),
        );
        break;
        
      default:
      
    }
  }

  Widget _buildIconHead(double _height, String str) {
    switch (str) {
      case "Approved":
        return CircleAvatar(
          backgroundColor: Colors.green,
          radius: _height * 0.06,
          child: Icon(
            Icons.check_circle_sharp,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
        case "Waiting for Check":
        return CircleAvatar(
          backgroundColor: Colors.yellow,
          radius: _height * 0.06,
          child: Icon(
            Icons.warning_amber_sharp,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
        case "Waiting for Approval":
        return CircleAvatar(
          backgroundColor: Colors.orange,
          radius: _height * 0.06,
          child: Icon(
            Icons.warning_amber_sharp,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
        case "Cancle By Maker":
        return CircleAvatar(
          backgroundColor: Colors.red,
          radius: _height * 0.06,
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
        case "Cancle By Checker":
        return CircleAvatar(
          backgroundColor: Colors.red,
          radius: _height * 0.06,
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
        case "Cancle By Authorizer":
        return CircleAvatar(
          backgroundColor: Colors.red,
          radius: _height * 0.06,
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: _height * 0.08,
          ),
        );
        break;
      default:
    }
  }
  Widget _buildBackgroundImageBlur(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assests/images/pink-geometric.jpg'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
