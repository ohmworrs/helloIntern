import 'dart:convert';


import 'package:corperate_banking/screens/screens_transaction/screens_transfer/check_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:rest_package/bean/delete_favourite_acct_request.dart';
import 'package:rest_package/bean/delete_favourite_acct_response.dart';
import 'package:rest_package/bean/delete_other_acct_request.dart';
import 'package:rest_package/bean/delete_other_acct_response.dart';
import 'package:rest_package/bean/favourite_acct_request.dart';
import 'package:rest_package/bean/favourite_acct_response.dart';
import 'package:rest_package/bean/other_user_acct_request.dart';
import 'package:rest_package/bean/other_user_acct_response.dart';
import 'package:rest_package/connection/checkAccount_connection.dart';
import 'package:rest_package/connection/delete_favourite_acct_connection.dart';
import 'package:rest_package/connection/delete_other_acct_connection.dart';
import 'package:rest_package/connection/favourite_acct_connection.dart';
import 'package:rest_package/connection/other_user_acct_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/company_user_acct_request.dart';
import 'package:rest_package/bean/company_user_acct_response.dart';
import 'package:rest_package/bean/company_user_acct_show_response.dart';
import 'package:rest_package/connection/company_user_acct_connection.dart';
import 'package:rest_package/model/favourite_acct_model_response.dart';
import 'package:rest_package/model/other_user_acct_model_response.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class TransferSingle1 extends StatefulWidget {
  String fromAccountName;
  String fromAccountType;
  String fromAccountNumber;
  String fromBankName;
  double fromAvailableBalnace;

  TransferSingle1(
      {
      this.fromAccountName,
      this.fromAccountType,
      this.fromAccountNumber,
      this.fromBankName,
      this.fromAvailableBalnace});

  @override
  _TransferSingle1State createState() => _TransferSingle1State(
      fromAccountName: fromAccountName,
      fromAccountType: fromAccountType,
      fromAccountNumber: fromAccountNumber,
      fromBankName: fromBankName,
      fromAvailableBalnace: fromAvailableBalnace);
}

class _TransferSingle1State extends State<TransferSingle1>
    with SingleTickerProviderStateMixin {
  String fromAccountName;
  String fromAccountType;
  String fromAccountNumber;
  double fromAvailableBalnace;
  String fromBankName;
  _TransferSingle1State(
      {this.fromAccountName,
      this.fromAccountType,
      this.fromAccountNumber,
      this.fromBankName,
      this.fromAvailableBalnace});
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  XSignature randReqRefNo = XSignature();
  final _formKey = GlobalKey<FormState>();
  CheckHasAccountConnection checkAcctConnect =
      CheckHasAccountConnection(globals.iPV4, '8080');
  CompanyUserAcctConnection companyUserAcctConnect =
      CompanyUserAcctConnection(globals.iPV4, '8080');
  OtherUserAcctConnection otherAcctConnect =
      OtherUserAcctConnection(globals.iPV4, '8080');
  FavouriteAcctConnection favouriteAcctConnect =
      FavouriteAcctConnection(globals.iPV4, '8080');
  DeleteOtherAcctConnection deleteOtherAcctConnect =
      DeleteOtherAcctConnection(globals.iPV4, '8080');
  DeleteFavouriteAcctConnection deleteFavConnect =
      DeleteFavouriteAcctConnection(globals.iPV4, '8080');

  TabController _controller;
  final amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  bool viewVisibleTransferInCompany = false;
  bool viewVisibleTransferOtherCompany = false;
  bool viewVisibleTransferPromtpay = false;
  String toBankName = "";
  String toAcctNumber = "";
  String toFName = "";
  String toLName = "";
  String transfType ="";
  String toAcctType="";

  Future<Null> refreshListCompanyAccts() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getCompanyUserAcct();
    });

    return null;
  }
  
  Future<Null> refreshListOtherUserAccts() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getAllAccountOtherCompany();
    });

    return null;
  }

  Future<Null> refreshListFavouriteAcctUser() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getFavaouriteAcct();
    });

    return null;
  }

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

  checkNameBank(String bankName) {
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

  Future<void> deleteFavouriteAcct(String first_Name, String last_Name, String acct_No) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoDeleteFavouriteAcct: ' + reqRefNo);
    DeleteFavouriteAcctRequest request = DeleteFavouriteAcctRequest(
        acct_No: acct_No,
        first_Name: first_Name,
        last_Name: last_Name,
        reqRefNo: reqRefNo);
    await deleteFavConnect
        .connectDeleteFavouriteAcct(request, globals.token)
        .then((value) {
      //print('status code DeleteFavouriteAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeleteFavouriteAcctResponse response =
            DeleteFavouriteAcctResponse.fromJson(responseMap);

        print("respDescDeleteFavouriteAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ลบบัญชีโปรดสำเร็จแล้ว",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          setState(() {
            getFavaouriteAcct();
          });
        }
      }
    });
  }

  Future<void> deleteOtherAcct(String acct_No, String acct_Name, String bankName) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    // print('reqRefNoDeleteOtherAcct: ' + reqRefNo);
    DeleteOtherAcctRequest request = DeleteOtherAcctRequest(
        acct_Name: acct_Name,
        acct_No: acct_No,
        bankName: bankName,
        reqRefNo: reqRefNo);
    await deleteOtherAcctConnect
        .connectDeleteOtherAcct(request, globals.token)
        .then((value) {
      //print('status code DeleteOtherAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeleteOtherAcctResponse response =
            DeleteOtherAcctResponse.fromJson(responseMap);
        print("respDescDeleteOtherAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ลบบัญชีบุคคลอื่นสำเร็จแล้ว",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          setState(() {
            getAllAccountOtherCompany();
          });
        }
      }
    });
  }

  Future<List<FavouriteAcctModelResponse>> getFavaouriteAcct() async {
    List<FavouriteAcctModelResponse> favouriteAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    // print('reqRefNoGetFavouriteUserAcct: ' + reqRefNo);
    FavouriteAcctRequest request = FavouriteAcctRequest(reqRefNo: reqRefNo);
    await favouriteAcctConnect
        .connectFavouriteAcct(request, globals.token)
        .then((value) {
      //print('status code getFavouriteUserAcct= ' + value.statusCode.toString());
      Map<String, dynamic> responseMap = jsonDecode(value.body);
      FavouriteAcctResponse response =
          FavouriteAcctResponse.fromJson(responseMap);
      if (reqRefNo == response.reqRefNo &&
          response.respCode == ResponseCode.APPROVED) {
        for (FavouriteAcctModelResponse data in response.listFavoriteAccount) {
          favouriteAcctList.add(data);
        }
      }
    });

    return favouriteAcctList;
  }

  Future<List<OtherUserAcctModelResponse>> getAllAccountOtherCompany() async {
    List<OtherUserAcctModelResponse> otherAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    // print('reqRefNoGetOtherUserAcct: ' + reqRefNo);

    OtherUserAcctRequest request = OtherUserAcctRequest(reqRefNo: reqRefNo);
    await otherAcctConnect
        .connectOtherUserAcct(request, globals.token)
        .then((value) {
      //print('status code getOtherUserAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        OtherUserAcctResponse response =
            OtherUserAcctResponse.fromJson(responseMap);
        print("respDescOtherUserAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (OtherUserAcctModelResponse data in response.otherUserAcctList) {
            otherAcctList.add(data);
          }
        }
      }
    });
    return otherAcctList;
  }

  Future<List<CompanyUserAcctResponse>> getCompanyUserAcct() async {
    List<CompanyUserAcctResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetCompanyUserAcct: ' + reqRefNo);
    CompanyUserAcctRequest request = CompanyUserAcctRequest(reqRefNo: reqRefNo);
    await companyUserAcctConnect
        .connectCompanyUserAcct(request, globals.token)
        .then((value) {
      //print('status code getCompanyUserAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CompanyUserAcctShowResponse response =
            CompanyUserAcctShowResponse.fromJson(responseMap);
        print("respDescCompanyUserAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (CompanyUserAcctResponse data in response.userAccount) {
            res.add(data);
          }
        }
      }
    });
    return res;
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    //refreshListCompanyAccts();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        
        key: this._scaffoldkey,
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
            'โอนเงิน',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Stack(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height,
                  child: Image.asset(
                    'assests/images/pink-geometric.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: _height * 0.015,
                    right: _height * 0.015,
                    top: _height * 0.038,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.03,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'จาก',
                                style: TextStyle(
                                    fontSize: _height * 0.023,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          Column(children: <Widget>[
                            InkWell(
                                child: Card(
                              elevation: 5,
                              child: Container(
                                height: _height * 0.1,
                                width: _width,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: _height,
                                      width: _width * 0.04,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: _height,
                                      width: _width * 0.2,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            checkLogoBank(fromBankName),
                                        backgroundColor: Colors.yellow,
                                        radius: _height * 0.03,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: _height,
                                      width: _width * 0.26,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: _height * 0.02,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              fromAccountType,
                                              style: TextStyle(
                                                  fontSize: _height * 0.018),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              fromAccountNumber,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: _height * 0.018),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: _height * 0.04,
                                    ),
                                    Container(
                                      height: _height,
                                      width: _width * 0.32,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: _height * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              '${formatMoney.format(fromAvailableBalnace)}'
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: _height * 0.024),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              ' บาท',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: _height * 0.015),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            SizedBox(
                              height: _height * 0.05,
                            ),
                            SizedBox(
                              height: _height * 0.03,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'ถึง',
                                  style: TextStyle(
                                      fontSize: _height * 0.023,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Container(
                                height: _height * 0.6,
                                width: _width,
                                color: Colors.white,
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        new Container(
                                          child: new TabBar(
                                            indicatorColor: Colors.pink,
                                            controller: _controller,
                                            tabs: [
                                              new Tab(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'บัญชีบุคคลภายในบริษัท',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize:
                                                            _height * 0.02),
                                                  ),
                                                ),
                                              ),
                                              new Tab(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'บัญชีบุคคลอื่น',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize:
                                                            _height * 0.02),
                                                  ),
                                                ),
                                              ),
                                              new Tab(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'บัญชีโปรด',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize:
                                                            _height * 0.02),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        new Container(
                                          height: _height * 0.5,
                                          child: new TabBarView(
                                            controller: _controller,
                                            children: <Widget>[
                                              //trasnfer company
                                              _buildCompanyUserAccts(context),

                                              //other transfer
                                              _buildOtherUserAccts(context),

                                              //favAccts
                                              _buildFavouriteUserAccts(context)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
       
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
        top: _height * 0.02,
      ),
      width: _width,
      height: _height * 0.62,
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                width: _width,
                height: _height * 0.1,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: _height,
                      width: _width * 0.2,
                      child: CircleAvatar(
                        backgroundImage: checkLogoBank(toBankName),
                      ),
                    ),
                    SizedBox(
                      width: _height * 0.02,
                    ),
                    Container(
                      child: Text(
                        checkNameBank(toBankName),
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                    )
                  ],
                )),
            Divider(
              height: _height * 0.01,
            ),
            Container(
              width: _width,
              height: _height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'หมายเลขบัญชี',
                    style: TextStyle(fontSize: _height * 0.024),
                  ),
                  Text(toAcctNumber,
                      style: TextStyle(
                          fontSize: _height * 0.024, color: Colors.grey))
                ],
              ),
            ),
            Divider(
              height: _height * 0.01,
            ),
            Container(
              width: _width,
              height: _height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'จำนวนเงิน (บาท)',
                    style: TextStyle(fontSize: _height * 0.024),
                  ),
                  Wrap(
                    spacing: _height * 0.01,
                    children: <Widget>[
                      Container(
                        height: _height * 0.05,
                        width: _width * 0.4,
                        child: TextFormField(
                          validator: (value){
                            value = amountController.text;
                            if(value.isEmpty){
                              return 'กรุณาใส่จำนวนเงิน';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.black, fontSize: _height * 0.023),
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'ระบุจำนวนเงิน',
                            hintStyle: TextStyle(fontSize: _height * 0.02),
                            labelStyle: TextStyle(fontSize: _height * 0.02),
                          ),
                         
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.bottomRight,
                      //   width: _width * 0.1,
                      //   height: _height * 0.05,
                      //   child: Text(
                      //     'บาท',
                      //     style: TextStyle(fontSize: _height * 0.02),
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: _height * 0.01,
            ),
            Container(
              width: _width,
              height: _height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'บันทึก',
                    style: TextStyle(fontSize: _height * 0.024),
                  ),
                  Wrap(
                    spacing: _height * 0.01,
                    children: <Widget>[
                      Container(
                        height: _height * 0.05,
                        width: _width * 0.4,
                        child: TextFormField(
                          validator: (value){
                            value = noteController.text;
                            if(value.isEmpty){
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.black, fontSize: _height * 0.023),
                          keyboardType: TextInputType.text,
                          controller: noteController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'ระบุบันทึกการโอน',
                            hintStyle: TextStyle(fontSize: _height * 0.02),
                            labelStyle: TextStyle(fontSize: _height * 0.02),
                            //enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: _height * 0.01,
            ),
            _buildButtonCheckTransf(context)
          ],
        ),
      ),
    );
  }

  Future<void>checkValidate(){
    if(_formKey.currentState.validate()){
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckTransferScreen(

                      fromAcctName: fromAccountName,
                      transfType: transfType,
                      fromAcctNumber: fromAccountNumber,
                      fromAcctType: fromAccountType,
                      fromBankName: fromBankName,
                      toAcctNumber: toAcctNumber,
                      toBankName: toBankName,
                      toFName: toFName,
                      toLName: toLName,
                      toAmount: double.parse(amountController.text),
                      toNote: noteController.text,
                    )));
    }else{
      print('Please Enter data!!');
    }

  }

  

  Widget _buildButtonCheckTransf(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        checkValidate();
      },
      child: Container(
        height: _height * 0.08,
        decoration: BoxDecoration(
          color: Colors.pink[300],
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          'ตรวจสอบข้อมูล',
          style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
        ),
      ),
      );
    // );
  }

  Widget _buildFavouriteUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.5,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListFavouriteAcctUser,
              child: FutureBuilder<List<FavouriteAcctModelResponse>>(
                future: getFavaouriteAcct(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var getAllFavourite = snapshot.data;
                    int lengthGetAllFavourite = getAllFavourite.length;
                    return ListView.builder(
                      itemCount: lengthGetAllFavourite,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            
                            transfType = "TTAF";
                            toFName = getAllFavourite[index].firstName_Th;
                            toLName = getAllFavourite[index].lastName_Th;
                            toAcctNumber = getAllFavourite[index].accountNo;
                            toBankName = getAllFavourite[index].bankName;
                            this._scaffoldkey.currentState.showBottomSheet(
                                (context) => _buildBottomSheet(context));
                          },
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                icon: Icons.delete,
                                color: Colors.pink,
                                onTap: () {
                                  deleteFavouriteAcct(
                                      getAllFavourite[index].firstName_Th,
                                      getAllFavourite[index].lastName_Th,
                                      getAllFavourite[index].accountNo);
                                },
                              )
                            ],
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  backgroundImage: checkLogoBank(
                                      getAllFavourite[index].bankName),
                                ),
                                title: Text(
                                  getAllFavourite[index].firstName_Th +
                                      ' ' +
                                      getAllFavourite[index].lastName_Th,
                                  style: TextStyle(
                                      fontSize: _height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'หมายเลขบัญชี ' +
                                      getAllFavourite[index].accountNo,
                                  style: TextStyle(
                                      fontSize: _height * 0.018,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.red,
                                  size: _height * 0.023,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtherUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.5,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListOtherUserAccts,
              child: FutureBuilder<List<OtherUserAcctModelResponse>>(
                future: getAllAccountOtherCompany(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var acctOtherCompany = snapshot.data;
                    var lengthAcctOtherCompany = acctOtherCompany.length;
                    return ListView.builder(
                      itemCount: lengthAcctOtherCompany,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                         
                            transfType="TTAOP";
                            toLName = "";
                            toFName = acctOtherCompany[index].acct_Name;
                            toAcctNumber = acctOtherCompany[index].acct_No;
                            toBankName = acctOtherCompany[index].bank_Name;
                            this._scaffoldkey.currentState.showBottomSheet(
                                (context) => _buildBottomSheet(context));
                          },
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                icon: Icons.delete,
                                color: Colors.pink,
                                onTap: () {
                                  deleteOtherAcct(
                                      acctOtherCompany[index].acct_No,
                                      acctOtherCompany[index].acct_Name,
                                      acctOtherCompany[index].bank_Name);
                                },
                              )
                            ],
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: checkLogoBank(
                                      acctOtherCompany[index].bank_Name),
                                ),
                                title: Text(
                                  acctOtherCompany[index].acct_Name,
                                  style: TextStyle(
                                      fontSize: _height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'หมายเลขบัญชี ' +
                                      acctOtherCompany[index].acct_No,
                                  style: TextStyle(
                                      fontSize: _height * 0.018,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.red,
                                  size: _height * 0.023,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCompanyUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.5,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListCompanyAccts,
              child: FutureBuilder<List<CompanyUserAcctResponse>>(
                future: getCompanyUserAcct(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var acctStaffs = snapshot.data;
                    int lenthAcctStaff = acctStaffs.length;
                    return ListView.builder(
                      itemCount: lenthAcctStaff,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                          
                            transfType = "TTAUC";
                            toFName = acctStaffs[index].firstName_Th;
                            toLName = acctStaffs[index].lastName_Th;
                            toAcctNumber = acctStaffs[index].accountNo;
                            toBankName = acctStaffs[index].bankName;
                            this._scaffoldkey.currentState.showBottomSheet(
                                (context) => _buildBottomSheet(context));
                            //showModalBottomSheet(context: context, builder: (ctx)=>_buildBottomSheet(ctx));
                            //showWidgetTransferInCompany();
                            //print(viewVisibleTransferInCompany);
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    checkLogoBank(acctStaffs[index].bankName),
                              ),
                              title: Text(
                                acctStaffs[index].firstName_Th +
                                    ' ' +
                                    acctStaffs[index].lastName_Th,
                                style: TextStyle(
                                    fontSize: _height * 0.02,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                'หมายเลขบัญชี ' + acctStaffs[index].accountNo,
                                style: TextStyle(
                                    fontSize: _height * 0.018,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.red,
                                size: _height * 0.023,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

//final formatMoney = new NumberFormat("#,##0.00", "en_US");
// class NumericTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.isEmpty) {
//       return newValue.copyWith(text: '');
//     } else if (newValue.text.compareTo(oldValue.text) != 0) {
//       final f = NumberFormat(
//         "#,###",
//       );
//       final number =
//           int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
//       //print(number);
//       final newString = f.format(number);
//       return TextEditingValue(
//         text: newString,
//         selection: TextSelection.collapsed(offset: newString.length),
//       );
//     } else {
//       return newValue;
//     }
//   }
// }
