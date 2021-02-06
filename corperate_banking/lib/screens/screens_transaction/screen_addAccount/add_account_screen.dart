import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_acct_other_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_add_promptpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddAccountScreen extends StatefulWidget {
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final tabController = PageController();
  var acctNumberController = MaskedTextController(text: '', mask: '000-000000-0');
  TextEditingController promptpayNumberController = TextEditingController();

  String bankName = 'ธนาคารไทยพาณิชย์';
  checkLogoBank(String bankName) {
    switch (bankName) {
      case "ธนาคารไทยพาณิชย์":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "ธนาคารกรุงเทพ":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "ธนาคารกรุงไทย":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "ธนาคารกรุงศรีอยุธยา":
        return AssetImage('assests/images/BAY.png');
        break;
      case "ธนาคารกสิกรไทย":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "ธนาคารทหารไทย":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "ธนาคารธนชาติ":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "ธนาคารอาคารสงเคราะห์":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "ธนาคารอมมสิน":
        return AssetImage('assests/images/GSB-logo.jpg');
        break;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xFFCFCFCF),
          appBar: _buildAppbar(context, _height),
          body: TabBarView(
            children: <Widget>[
              _buildOtherAccount(context),
              _buildOtherPromptpay(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, double _height) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: Colors.pink[300],
      centerTitle: true,
      title: Text(
        'เพิ่มบัญชี',
        style:
            TextStyle(fontSize: _height * 0.023, fontWeight: FontWeight.w500),
      ),
      bottom: TabBar(
        indicatorColor: Colors.pink,
        tabs: <Tab>[
          Tab(
            child: Text(
              'เพิ่มบัญชีบุคคลอื่น',
              style: TextStyle(fontSize: _height * 0.023),
            ),
          ),
          Tab(
            child: Text(
              'เพิ่มบัญชีพร้อมเพย์',
              style: TextStyle(fontSize: _height * 0.023),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtherAccount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFCFCFCF), Colors.white])),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'กรุณากรอกข้อมูล',
                  style: TextStyle(
                      fontSize: _height * 0.023, fontWeight: FontWeight.w500),
                )),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: _height * 0.1,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(40)),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.035,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        top: _height * 0.02),
                    height: _height * 0.68,
                    width: _width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'เลือกธนาคาร',
                              style: TextStyle(fontSize: _height * 0.023),
                            ),
                            DropdownButton(
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'ThaiSansNeue'),
                              value: bankName,
                              items: <String>[
                                'ธนาคารไทยพาณิชย์',
                                'ธนาคารกรุงเทพ',
                                'ธนาคารกรุงไทย',
                                'ธนาคารกรุงศรีอยุธยา',
                                'ธนาคารกสิกรไทย',
                                'ธนาคารทหารไทย',
                                'ธนาคารธนชาติ',
                                'ธนาคารออมสิน',
                                'ธนาคารอาคารสงเคราะห์'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  bankName = newValue;
                                  print('ธนาคารที่เลือก: ' + bankName);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'หมายเลขบัญชี',
                                style: TextStyle(fontSize: _height * 0.023),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(fontSize: _height * 0.023),
                                controller: acctNumberController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'ใส่หมายเลขบัญชี'),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: _width * 0.5,
                            height: _height * 0.05,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckAddAcctOtherScreen(
                                                    acctNumber:
                                                        acctNumberController
                                                            .text,
                                                    bankName: bankName,
                                                  )));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.pink[300],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'ตรวจสอบข้อมูล',
                                        style: TextStyle(
                                            fontSize: _height * 0.018,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOtherPromptpay(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFCFCFCF), Colors.white])),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'กรุณากรอกข้อมูล',
                  style: TextStyle(
                      fontSize: _height * 0.023, fontWeight: FontWeight.w500),
                )),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: _height * 0.1,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(40)),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.035,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        top: _height * 0.02),
                    height: _height * 0.68,
                    width: _width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              'หมายเลขบัญชี',
                              style: TextStyle(fontSize: _height * 0.023),
                            )),
                            Expanded(
                              child: Container(
                                width: _width,
                                height: _height * 0.05,
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextFormField(
                                  controller: promptpayNumberController,
                                  style: TextStyle(fontSize: _height * 0.02),
                                  decoration: InputDecoration(
                                    hintText:
                                        ' หมายเลขบัตรประชาชน / เบอร์โทรศัพท์',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: _width * 0.5,
                            height: _height * 0.05,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckAddPromptpayScreen(
                                                    promptpayNumber:
                                                        promptpayNumberController
                                                            .text,
                                                  )));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.pink[300],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'ตรวจสอบข้อมูล',
                                        style: TextStyle(
                                            fontSize: _height * 0.018,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
