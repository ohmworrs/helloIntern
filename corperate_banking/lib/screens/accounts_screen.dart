import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/ostdTotal_response.dart';
import 'package:rest_package/connection/graph_connection.dart';
import 'package:rest_package/bean/graph_request.dart';
import 'package:rest_package/bean/graph_show_response.dart';
import 'package:rest_package/bean/accounts_request.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/accounts_show_response.dart';
import 'package:rest_package/connection/accounts_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/accounts_model.dart';
import 'package:rest_package/bean/graph_response.dart';
import 'package:rest_package/connection/ostdTotal_connection.dart';
import 'package:rest_package/bean/ostdTotal_request.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  AccountsConnection acctConnect = AccountsConnection(globals.iPV4, '8080');
  GraphConnection graphConnect = GraphConnection(globals.iPV4, '8080');
  OSTDTotalConnection ostdTotalConnect =
      OSTDTotalConnection(globals.iPV4, '8080');
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

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  Future<double> getOSTDTotal() async {
    double ostdTotal;
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoSumOstd: ' + reqRefNo);
    OSTDTotalRequest request = OSTDTotalRequest(reqRefNo: reqRefNo);
    await ostdTotalConnect
        .connectOSTDTotal(request, globals.token)
        .then((value) {
      print('status code getOSTDTotal= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        OSTDTotalResponse response = OSTDTotalResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          ostdTotal = response.sumOstdBalance;
        }
      }
    });

    return ostdTotal;
  }

  Future<Map<String, double>> getGraph() async {
    Map<String, double> getGraphMap = {};
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    print('reqRefNGraph: ' + reqRefNo);
    GraphRequest request = GraphRequest(reqRefNo: reqRefNo);
    await graphConnect.connectGraph(request, globals.token).then((value) {
      print('status code getGraph= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        GraphShowResponse response = GraphShowResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (GraphResponse data in response.accountList) {
            //print(data.accType + ' ' + data.ostdBalance.toString());
            getGraphMap[data.accType] = data.ostdBalance;
          }
        }
      }
    });

    return getGraphMap;
  }

  Future<List<AccountsShowData>> getAllAccounts() async {
    List<AccountsResponse> dataAcctSaving = [];
    List<AccountsResponse> dataAcctCurrent = [];
    List<AccountsResponse> dataAcctFixed = [];
    List<AccountsShowData> allAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAcct: ' + reqRefNo);
    AccountsRequest request = AccountsRequest(reqRefNo: reqRefNo);

    await acctConnect.connectAccounts(request, globals.token).then((value) {
      //print('status code getAccts= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AccountsShowResponse response =
            AccountsShowResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (AccountsResponse data in response.accounts) {
            if (data.accType == 'บัญชีออมทรัพย์') {
              dataAcctSaving.add(data);
              // print('add '+data.acctNo+' success');
            }
            if (data.accType == 'บัญชีกระแสรายวัน') {
              dataAcctCurrent.add(data);
              // print('add '+data.acctNo+' success');
            }
            if (data.accType == 'บัญชีเงินฝากประจำ') {
              dataAcctFixed.add(data);
              //print('add '+data.acctNo+' success');
            }
          }
          // print('dataAcctSaving length: '+dataAcctSaving.length.toString());
          // print('dataAcctCurrent length: '+dataAcctCurrent.length.toString());
          // print('dataAcctFixed length: '+dataAcctFixed.length.toString());
          allAcctList.add(
            AccountsShowData(
                acctType: 'บัญชีออมทรัพย์', acctData: dataAcctSaving),
          );
          allAcctList.add(
            AccountsShowData(
                acctType: 'บัญชีกระแสรายวัน', acctData: dataAcctCurrent),
          );
          allAcctList.add(AccountsShowData(
              acctType: 'บัญชีเงินฝากประจำ', acctData: dataAcctFixed));
          // print('allAcctList length: '+allAcctList.length.toString());
        }
      }
    });
    return allAcctList;
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.pink[300],
          centerTitle: true,
          title: Text(
            'Coporate Mobile Banking',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFCFCFCF)])),
          child: Stack(
            children: <Widget>[
              Container(
                height: _height,
                width: _width,
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
                        colors: [Colors.transparent, Colors.pink[50]])),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: _height * 0.02,
                      right: _height * 0.02,
                      // top: _height * 0.01,
                      // bottom: _height * 0.01,
                    ),
                    height: _height * 0.1,
                    width: _width,
                    child: FutureBuilder<double>(
                      future: getOSTDTotal(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var ostdTotal = snapshot.data;
                          return ListTile(
                            title: Text(
                              'ยอดรวมสินทรัพย์',
                              style: TextStyle(
                                  fontSize: _height * 0.028,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              '${formatMoney.format(ostdTotal)}' + ' บาท',
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: _height * 0.02,
                      right: _height * 0.02,
                      // top: _height * 0.01,
                      // bottom: _height * 0.01,
                    ),
                    height: _height * 0.23,
                    width: _width,
                    child: FutureBuilder<Map<String, double>>(
                      future: getGraph(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var graph = snapshot.data;

                          return PieChart(
                            dataMap: graph,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: _height * 0.05,
                            chartRadius: _height * 0.15,
                            colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: _height * 0.05,
                            centerText: "",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                  fontFamily: 'ThaiSansNeue',
                                  fontSize: _height * 0.023),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: _height * 0.1,
                        width: _width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: Colors.pink[50],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.04,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            height: _height * 0.4,
                            width: _width,
                            color: Colors.pink[50],
                            padding: EdgeInsets.only(
                              left: _height * 0.02,
                              right: _height * 0.02,
                              // top: _height * 0.01,
                              // bottom: _height * 0.01,
                            ),
                            child: FutureBuilder<List<AccountsShowData>>(
                              future: getAllAccounts(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  var acct = snapshot.data;

                                  return ListView.builder(
                                    itemCount: acct.length,
                                    itemBuilder: (context, int i) {
                                      return Card(
                                        color: Colors.pink[300],
                                        elevation: 5,
                                        child: ExpansionTile(
                                          title: Text(
                                            acct[i].acctType,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: _height * 0.023,
                                                color: Colors.white),
                                          ),
                                          children: <Widget>[
                                            Column(
                                                children:
                                                    _buildExpandableContent(
                                                        context, acct[i])),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  _buildExpandableContent(BuildContext context, AccountsShowData account) {
    final double _height = MediaQuery.of(context).size.height;
    List<Widget> columnContent = [];

    for (AccountsResponse content in account.acctData)
      columnContent.add(
        Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: checkLogoBank(content.bankName),
              ),
              title: Text(
                'หมายเลขบัญชี ' + content.acctNo,
                style: TextStyle(
                    fontSize: _height * 0.02,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              subtitle: Text(
                'ยอดเงินที่สามารถใช้ได้ ' +
                    '${formatMoney.format(content.availableBalance)}' +
                    ' บาท' +
                    '\n'
                        'ยอดเงินคงเหลือในบัญชี ' +
                    '${formatMoney.format(content.ostdBalance)}' +
                    ' บาท',
                style: TextStyle(
                    fontSize: _height * 0.018,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              //subtitle: functionCallavailableBalance(account.availableBalance,i)
            ),
            Divider(color: Colors.white),
          ],
        ),
      );
    return columnContent;
  }
}
