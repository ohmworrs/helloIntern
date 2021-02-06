import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateOrderTransferScreen extends StatefulWidget {
  String fromBankName;
  String fromAcctType;
  String fromAcctNumber;
  String toBankName;
  String toFName;
  String toLName;
  String toAcctNumber;
  double toAmount;
  String toNote;
  String tracNo;
  String dateTime;
  double fee;

  CreateOrderTransferScreen(
      {this.toAcctNumber,
      this.toBankName,
      this.toAmount,
      this.toNote,
      this.toLName,
      this.toFName,
      this.fromAcctType,
      this.fromAcctNumber,
      this.fromBankName,
      this.dateTime,
      this.tracNo,
      this.fee});

  @override
  _CreateOrderTransferScreenState createState() =>
      _CreateOrderTransferScreenState(
        fromAcctNumber: fromAcctNumber,
        fromAcctType: fromAcctType,
        fromBankName: fromBankName,
        toAcctNumber: toAcctNumber,
        toBankName: toBankName,
        toFName: toFName,
        toLName: toLName,
        toAmount: toAmount,
        toNote: toNote,
        dateTime: dateTime,
        tracNo: tracNo,
        fee: fee,
      );
}

class _CreateOrderTransferScreenState extends State<CreateOrderTransferScreen> {
  String fromBankName = "";
  String fromAcctType = "";
  String fromAcctNumber = "";
  String toBankName = "";
  String toFName = "";
  String toLName = "";
  String toAcctNumber = "";
  double toAmount;
  String toNote = "";
  String dateTime;
  String tracNo;
  double fee;
  _CreateOrderTransferScreenState(
      {this.toAcctNumber,
      this.toBankName,
      this.toAmount,
      this.toNote,
      this.toLName,
      this.toFName,
      this.fromAcctType,
      this.fromAcctNumber,
      this.fromBankName,
      this.tracNo,
      this.dateTime,
      this.fee});

  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  TextEditingController qrTextController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "สร้างรายการสำเร็จ โปรดตรวจสอบสถานะการอนุมัติต่อไป",
        textStyle: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.08,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _width,
                    height: _height * 0.1,
                    child: Image.asset(
                        'assests/images/logo_isc_medium_orange.png'),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(
                            left: _height * 0.02, right: _height * 0.02),
                        width: _width,
                        height: _height * 0.8,
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
                                left: _height * 0.02, right: _height * 0.02),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: _width,
                                  height: _height * 0.72,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.05,
                                      ),
                                      Container(
                                          width: _width,
                                          
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: _height * 0.01,
                                              ),
                                              Container(
                                                height: _height * 0.045,
                                                width: _width,
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  'สร้างรายการสำเร็จ',
                                                  style: TextStyle(
                                                      fontSize: _height * 0.04,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Container(
                                                height: _height * 0.03,
                                                width: _width,
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  dateTime,
                                                  style: TextStyle(
                                                      fontSize: _height * 0.023,
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
                                                      padding: EdgeInsets.only(
                                                        left: _height * 0.02,
                                                      ),
                                                      width: _width,
                                                      height: _height * 0.075,
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
                                                            width: _width * 0.1,
                                                            height: _height,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                          Container(
                                                            width:
                                                                _width * 0.15,
                                                            height: _height,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  checkLogoBank(
                                                                      fromBankName),
                                                              backgroundColor:
                                                                  Colors.yellow,
                                                              radius: _height *
                                                                  0.03,
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                _width * 0.55,
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
                                                                  fromAcctType,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          _height *
                                                                              0.023),
                                                                ),
                                                                Text(
                                                                  fromAcctNumber,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          _height *
                                                                              0.02,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width,
                                                      height: _height * 0.09,
                                                      padding: EdgeInsets.only(
                                                        left: _height * 0.02,
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
                                                            width: _width * 0.1,
                                                            height: _height,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                          Container(
                                                            width:
                                                                _width * 0.15,
                                                            height: _height,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  checkLogoBank(
                                                                      toBankName),
                                                              backgroundColor:
                                                                  Colors.yellow,
                                                              radius: _height *
                                                                  0.03,
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                _width * 0.55,
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
                                                                  toFName +
                                                                      ' ' +
                                                                      toLName,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          _height *
                                                                              0.023),
                                                                ),
                                                                // Text(
                                                                //   checkNameBankFromLogo(toBankName),
                                                                //   style: TextStyle(
                                                                //       fontSize:
                                                                //           _height *
                                                                //               0.015,
                                                                //       color: Colors
                                                                //           .grey),
                                                                // ),
                                                                Text(
                                                                  toAcctNumber,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          _height *
                                                                              0.02,
                                                                      color: Colors
                                                                          .grey),
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
                                                width: _width,
                                                height: _height * 0.06,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'เลขที่รายการ :',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                      width: _width * 0.23,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.57,
                                                      child: Text(
                                                        tracNo,
                                                        style: TextStyle(
                                                            fontSize:
                                                                _height * 0.03),
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
                                                width: _width,
                                                height: _height * 0.06,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'จำนวนเงิน :',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                      width: _width * 0.23,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.5,
                                                      child: Text(
                                                        '${formatMoney.format(toAmount)}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                _height * 0.03),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.06,
                                                      child: Text(
                                                        'บาท',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.018),
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
                                                width: _width,
                                                height: _height * 0.06,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'ค่าธรรมเนียม :',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                      width: _width * 0.23,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.5,
                                                      child: Text(
                                                        '${formatMoney.format(fee)}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                _height * 0.03),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.06,
                                                      child: Text(
                                                        'บาท',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.018),
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
                                                width: _width,
                                                height: _height * 0.06,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'บันทึก :',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                      width: _width * 0.23,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      height: _height,
                                                      width: _width * 0.57,
                                                      child: Text(
                                                        toNote,
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.018),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: _width,
                                                height: _height * 0.15,
                                              
                                                padding: EdgeInsets.only(
                                                    left: _height * 0.02,
                                                    top: _height * 0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        'ท่านสามารถสแกนคิวอาร์โค้ดนี้\nเพื่อตรวจสอบสถานะการโอนเงิน',
                                                        style: TextStyle(
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width * 0.25,
                                                      height: _height,
                                                      
                                                      child: QrImage(
                                                        data: tracNo,
                                                      ),
                                                    ),
                                                    Container()
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
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                            PageTo.indexScreen));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.pink[300],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'เสร็จสิ้น',
                                      style: TextStyle(
                                          fontSize: _height * 0.023,
                                          color: Colors.white),
                                    ),
                                    width: _width,
                                    height: _height * 0.07,
                                  ),
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
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: _height * 0.05,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: _height * 0.09,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
