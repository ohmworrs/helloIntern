import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CheckerCheckOrederSuccessScreen extends StatefulWidget {
  @override
  _CheckerCheckOrederSuccessScreenState createState() =>
      _CheckerCheckOrederSuccessScreenState();
}

class _CheckerCheckOrederSuccessScreenState
    extends State<CheckerCheckOrederSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, _height),
        backgroundColor: Colors.pink[50],
        body: Container(
          height: _height,
          width: _width,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.065,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: _height * 0.02, right: _height * 0.02),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                height: _height * 0.69,
                                width: _width,
                                child: ClipPath(
                                  clipper: PointsClipper(),
                                  child: Container(
                                    color: Colors.white,
                                    width: _width,
                                    height: _height * 0.1,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.065,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: _height * 0.02, right: _height * 0.02),
                              child: Container(
                                height: _height * 0.65,
                                width: _width,
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: _height * 0.09,
                                    ),
                                    _buildData(context)
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.03,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check_circle,
                              size: _height * 0.13,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: _height*0.02,),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.03, right: _height * 0.03),
                    height: _height * 0.075,
                    width: _width,
                    child: InkWell(
                      onTap: () {
                         Navigator.of(context) .popUntil(ModalRoute.withName(PageTo.checkerOrderScreen));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.pink[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          alignment: Alignment.center,
                          height: _height,
                          width: _width,
                          child: Text(
                            'เสร็จสิ้น',
                            style: TextStyle(
                                fontSize: _height * 0.026, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double _height) {
    return AppBar(
      leading: Container(),
      backgroundColor: Colors.pink[300],
      centerTitle: true,
      title: Text(
        'การตรวจสอบ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01, right: _height * 0.01),
      height: _height * 0.56,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'รายการการโอน',
              style: TextStyle(
                  fontSize: _height * 0.04, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '13 เมษายน 2563 16:30:30',
              style: TextStyle(fontSize: _height * 0.023, color: Colors.grey),
            ),
          ),
          Container(
            width: _width,
            height: _height * 0.17,
            child: Column(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height * 0.075,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'จาก',
                          style: TextStyle(fontSize: _height * 0.023),
                        ),
                        width: _width * 0.1,
                        height: _height,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: _width * 0.15,
                        height: _height,
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assests/images/logo_isc_medium_orange.png'),
                          backgroundColor: Colors.yellow,
                          radius: _height * 0.03,
                        ),
                      ),
                      Container(
                        width: _width * 0.55,
                        height: _height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Text(
                              'ออมทรัพย์',
                              style: TextStyle(fontSize: _height * 0.018),
                            ),
                            Text(
                              '999-9-9999-9',
                              style: TextStyle(
                                  fontSize: _height * 0.015,
                                  color: Colors.grey),
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'ถึง',
                          style: TextStyle(fontSize: _height * 0.023),
                        ),
                        width: _width * 0.1,
                        height: _height,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: _width * 0.15,
                        height: _height,
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assests/images/SCB-logo.png'),
                          backgroundColor: Colors.yellow,
                          radius: _height * 0.03,
                        ),
                      ),
                      Container(
                        width: _width * 0.55,
                        height: _height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Text(
                              'คุณ ตัวอย่าง ตัวอย่าง',
                              style: TextStyle(fontSize: _height * 0.018),
                            ),
                            // Text(
                            //   'ธนาคารไทยพาณิชย์',
                            //   style: TextStyle(
                            //       fontSize: _height * 0.015,
                            //       color: Colors.grey),
                            // ),
                            Text(
                              '777-7-7777-7',
                              style: TextStyle(
                                  fontSize: _height * 0.015,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'เลขที่รายการ :',
                      style: TextStyle(fontSize: _height * 0.023),
                    ),
                  ),
                  Container(
                    child: Text(
                      '1234567890',
                      style: TextStyle(fontSize: _height * 0.03),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'จำนวนเงิน :',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
              ),
              Container(
                child: Text(
                  '7,000.00' + ' บาท',
                  style: TextStyle(fontSize: _height * 0.03),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'ค่าธรรมเนียม :',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
              ),
              Container(
                child: Text(
                  '0.00' + ' บาท',
                  style: TextStyle(fontSize: _height * 0.03),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'บันทึก :',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
              ),
              Container(
                child: Text(
                  'ทดสอบการบันทึก ทดสอบการบันทึก ',
                  style: TextStyle(fontSize: _height * 0.018),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'สถานะการทำรายการ :',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
              ),
              Container(
                child: Text(
                  'ตรวจสอบเรียบร้อย',
                  style: TextStyle(fontSize: _height * 0.018),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  'ผู้ตรวจสอบ :',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
              ),
              Container(
                child: Text(
                  'คุณ ' + 'ตัวอย่าง' + ' ' + 'ตัวอย่าง',
                  style: TextStyle(fontSize: _height * 0.018),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
