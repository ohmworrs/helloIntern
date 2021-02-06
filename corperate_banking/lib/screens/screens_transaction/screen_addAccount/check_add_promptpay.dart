import 'dart:ui';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CheckAddPromptpayScreen extends StatefulWidget {
  String promptpayNumber;
  CheckAddPromptpayScreen({
    this.promptpayNumber
  });
  @override
  _CheckAddPromptpayScreenState createState() => _CheckAddPromptpayScreenState(promptpayNumber: promptpayNumber);
}

class _CheckAddPromptpayScreenState extends State<CheckAddPromptpayScreen> {
  String promptpayNumber;
  _CheckAddPromptpayScreenState({
    this.promptpayNumber
  });
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: <Widget>[
            _buildBackgroundImageBlur(context),
            Container(
              padding:
                  EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
              width: _width,
              height: _height,
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  _buildCheckData(context),
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      print('add promptpay account success');
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "เพิ่มบัญชีพร้อมเพย์สำเร็จ",
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      );
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(PageTo.indexScreen));
                    },
                    child: Card(
                      color: Colors.pink,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Container(
                        alignment: Alignment.center,
                        width: _width,
                        height: _height * 0.08,
                        child: Text(
                          'เพิ่มบัญชี',
                          style: TextStyle(
                              fontSize: _height * 0.024, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      
      
    );
  }
  Widget _buildCheckData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: EdgeInsets.only(left: _height * 0.01, right: _height * 0.01),
        width: _width,
        height: _height * 0.3,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              width: _width,
              height: _height * 0.1,
              child: CircleAvatar(
                radius: _height * 0.05,
                backgroundImage: AssetImage('assests/images/avatar-circle.png'),
              ),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ธนาคาร',
                  style: TextStyle(fontSize: _height * 0.024),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //width: _width*0.4,
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    color: Colors.grey[300],
                    child: Text(
                      'ธนาคารไทยพาณิชย์',
                      style: TextStyle(fontSize: _height * 0.024),
                    ))
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'หมายเลขพร้อมเพย์',
                  style: TextStyle(fontSize: _height * 0.024),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //width: _width*0.4,
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    color: Colors.grey[300],
                    child: Text(
                      '1 123123 1',
                      style: TextStyle(fontSize: _height * 0.024),
                    ))
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ชื่อบัญชี',
                  style: TextStyle(fontSize: _height * 0.024),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //width: _width*0.4,
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    color: Colors.grey[300],
                    child: Text(
                      'คุณ' + 'ตัวอย่าง' + ' ' + 'ตัวอย่าง',
                      style: TextStyle(fontSize: _height * 0.024),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
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

  Widget _buildAppBar(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        title: Text(
          'ตรวจสอบบัญชีพร้อมเพย์',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}