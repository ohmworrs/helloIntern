import 'dart:convert';

import 'package:corperate_banking/model/getAllOrderResponse.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_order/order-detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/transf_order_request.dart';
import 'package:rest_package/bean/transf_order_response.dart';
import 'package:rest_package/connection/transf_order_all_connection.dart';
import 'package:rest_package/connection/transf_order_approved_connection.dart';
import 'package:rest_package/connection/transf_order_cancles_connection.dart';
import 'package:rest_package/connection/transf_order_wait_approvel_connection.dart';
import 'package:rest_package/connection/transf_order_wait_checker_connection.dart';
import 'package:rest_package/constant/response_code.dart';

import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/transf_order_model_response.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool setAll = true;
  bool setApproval = false;
  bool setWaitCheck = false;
  bool setWaitApproval = false;
  bool setNotSuccess = false;
  String tracNo;

  XSignature randReqRefNo = XSignature();
  TransfOrderAllConnection transfOrderAllconnect =
      TransfOrderAllConnection(globals.iPV4, '8080');
  TransfOrderWaitApprovelConnection transfOrderWaitAprroval =
      TransfOrderWaitApprovelConnection(globals.iPV4, '8080');
  TransfOrderWaitCheckerConnection transfOrderWaitChecker =
      TransfOrderWaitCheckerConnection(globals.iPV4, '8080');
  TransfOrderApprovedConnection transfOrderApproved =
      TransfOrderApprovedConnection(globals.iPV4, '8080');
  TransfOrderCanclesConnection transfOrderCancles =
      TransfOrderCanclesConnection(globals.iPV4, '8080');

  Future<List<TransfOrderModelResponse>> getOrderAll() async {
    List<TransfOrderModelResponse> resOrderAll = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderAll: ' + reqRefNo);
    TransfOrderRequest request = TransfOrderRequest(reqRefNo: reqRefNo);
    await transfOrderAllconnect
        .connectTransfOrderAll(request, globals.token)
        .then((value) {
      //print('status code GetOrderAll= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderAll: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderAll.add(data);
          }
        }
      }
    });
    return resOrderAll;
  }

  Future<List<TransfOrderModelResponse>> getOrderWaitApproval() async {
    List<TransfOrderModelResponse> resOrderWaitAproval = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderWaitApproval: ' + reqRefNo);
    TransfOrderRequest request = TransfOrderRequest(reqRefNo: reqRefNo);
    await transfOrderWaitAprroval
        .connectTransfOrderWaitApprovel(request, globals.token)
        .then((value) {
      //print('status code GetOrderWaitApproval= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderWaitApproval: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitAproval.add(data);
          }
        }
      }
    });
    return resOrderWaitAproval;
  }

  Future<List<TransfOrderModelResponse>> getOrderApproved() async {
    List<TransfOrderModelResponse> resOrderWaitAproval = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderApproved: ' + reqRefNo);
    TransfOrderRequest request = TransfOrderRequest(reqRefNo: reqRefNo);
    await transfOrderApproved
        .connectTransfOrderApproved(request, globals.token)
        .then((value) {
      //print('status code GetOrderApproved= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderApproved: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitAproval.add(data);
          }
        }
      }
    });
    return resOrderWaitAproval;
  }

  Future<List<TransfOrderModelResponse>> getOrderWaitChecker() async {
    List<TransfOrderModelResponse> resOrderWaitChecker = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderWaitChecker: ' + reqRefNo);
    TransfOrderRequest request = TransfOrderRequest(reqRefNo: reqRefNo);
    await transfOrderWaitChecker
        .connectTransfOrderWaitChecker(request, globals.token)
        .then((value) {
      //print('status code GetOrderWaitChecker= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderWaitChecker: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitChecker.add(data);
          }
        }
      }
    });
    return resOrderWaitChecker;
  }

  Future<List<TransfOrderModelResponse>> getOrderCancles() async {
    List<TransfOrderModelResponse> resOrderCancles = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderCancles: ' + reqRefNo);
    TransfOrderRequest request = TransfOrderRequest(reqRefNo: reqRefNo);
    await transfOrderCancles
        .connectTransfOrderCancles(request, globals.token)
        .then((value) {
      //print('status code GetOrderCancles= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderCancles: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderCancles.add(data);
          }
        }
      }
    });
    return resOrderCancles;
  }

  checkStatus(String status) {
    switch (status) {
      case 'Approved':
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 40,
        );
        break;
      case 'Waiting for Check':
        return Icon(
          Icons.check_circle,
          color: Colors.yellow,
          size: 40,
        );
        break;
      case 'Waiting for Approval':
        return Icon(
          Icons.check_circle,
          color: Colors.orange,
          size: 40,
        );
        break;
      case 'Cancle By Maker':
        return Icon(
          Icons.remove_circle,
          color: Colors.pink[300],
          size: 40,
        );
        break;
      case 'Cancle By Checker':
        return Icon(
          Icons.remove_circle,
          color: Colors.pink[300],
          size: 40,
        );
        break;
      case 'Cancle By Authorizer':
        return Icon(
          Icons.remove_circle,
          color: Colors.pink[300],
          size: 40,
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFCFCFCF),
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.pink[300],
          centerTitle: true,
          title: Text(
            'รายการ',
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
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.white])),
            ),
            Container(
              height: _height,
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      left: _height * 0.02,
                    ),
                    child: Text(
                      'รายการการโอน',
                      style: TextStyle(
                          fontSize: _height * 0.023,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: _buildButtomAllOrder(context)),
                      SizedBox(
                        width: _height * 0.005,
                      ),
                      Expanded(child: _buildButtonAprroved(context)),
                      SizedBox(
                        width: _height * 0.005,
                      ),
                      Expanded(child: _buildButtonWaitChecker(context)),
                      SizedBox(
                        width: _height * 0.005,
                      ),
                      Expanded(child: _buildButtonWaitApprovel(context)),
                      SizedBox(
                        width: _height * 0.005,
                      ),
                      Expanded(child: _buildButtonNotSuccess(context)),
                    ],
                  ),
                  SizedBox(
                    height: _height * 0.03,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          height: _height * 0.1,
                          width: _width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42),
                              color: Colors.white)),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.04,
                          ),
                          Container(
                              color: Colors.white,
                              height: _height * 0.62,
                              width: _width,
                              child: Stack(
                                children: <Widget>[
                                  _buildVisibilityAllOrderData(context),
                                  _buildVisibilityApprovedData(context),
                                  _buildVisibilityWaitCheckerData(context),
                                  _buildVisibilityWaitApprovelData(context),
                                  _buildVisibilityNotSuccessData(context)
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtomAllOrder(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = true;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
            color: setAll == true ? Colors.pink[300] : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Text(
          'ทั้งหมด',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setAll == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonAprroved(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = true;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
            color: setApproval == true ? Colors.pink[300] : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Text(
          'อนุมัติแล้ว',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setApproval == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonWaitChecker(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = true;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setWaitCheck == true ? Colors.pink[300] : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'รอการตรวจสอบ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setWaitCheck == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonWaitApprovel(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = true;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setWaitApproval == true ? Colors.pink[300] : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'รอการอนุมัติ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setWaitApproval == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonNotSuccess(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = true;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setNotSuccess == true ? Colors.pink[300] : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'ไม่สำเร็จ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setNotSuccess == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildVisibilityAllOrderData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setAll,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: InkWell(
                        onTap: () {
                          tracNo = orders[index].trace_No;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        tracNo: tracNo,
                                      )));
                        },
                        child: ListTile(
                          leading: checkStatus(orders[index].trnStatus),
                          title: Text(
                            'เลขที่รายการ ' + orders[index].trace_No,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            orders[index].to_Acct_Name_Th,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: _height * 0.01,
                            children: <Widget>[
                              Text(orders[index].dateTime),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: _height * 0.02,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityApprovedData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setApproval,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderApproved(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: InkWell(
                        onTap: () {
                          tracNo = orders[index].trace_No;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        tracNo: tracNo,
                                      )));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: _height * 0.04,
                          ),
                          title: Text(
                            'เลขที่รายการ ' + orders[index].trace_No,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            orders[index].to_Acct_Name_Th,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: _height * 0.01,
                            children: <Widget>[
                              Text(orders[index].dateTime),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: _height * 0.02,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityWaitCheckerData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setWaitCheck,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderWaitChecker(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: InkWell(
                        onTap: () {
                          tracNo = orders[index].trace_No;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        tracNo: tracNo,
                                      )));
                        },
                        child: ListTile(
                          leading: checkStatus(orders[index].trnStatus),
                          title: Text(
                            'เลขที่รายการ ' + orders[index].trace_No,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            orders[index].to_Acct_Name_Th,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: _height * 0.01,
                            children: <Widget>[
                              Text(orders[index].dateTime),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: _height * 0.02,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityWaitApprovelData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setWaitApproval,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderWaitApproval(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: InkWell(
                        onTap: () {
                          tracNo = orders[index].trace_No;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        tracNo: tracNo,
                                      )));
                        },
                        child: ListTile(
                          leading: checkStatus(orders[index].trnStatus),
                          title: Text(
                            'เลขที่รายการ ' + orders[index].trace_No,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            orders[index].to_Acct_Name_Th,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: _height * 0.01,
                            children: <Widget>[
                              Text(orders[index].dateTime),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: _height * 0.02,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityNotSuccessData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setNotSuccess,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderCancles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: InkWell(
                        onTap: () {
                          tracNo = orders[index].trace_No;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailScreen(
                                        tracNo: tracNo,
                                      )));
                        },
                        child: ListTile(
                          leading: checkStatus(orders[index].trnStatus),
                          title: Text(
                            'เลขที่รายการ ' + orders[index].trace_No,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            orders[index].to_Acct_Name_Th,
                            style: TextStyle(
                              fontSize: _height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Wrap(
                            spacing: _height * 0.01,
                            children: <Widget>[
                              Text(orders[index].dateTime),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: _height * 0.02,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
