import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthorizerCheckScreen extends StatefulWidget {
  @override
  _AuthorizerCheckScreenState createState() => _AuthorizerCheckScreenState();
}

class _AuthorizerCheckScreenState extends State<AuthorizerCheckScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                  padding: EdgeInsets.only(left: _height * 0.02),
                  child: Text(
                    'รายละเอียดการโอนเงิน',
                    style: TextStyle(fontSize: _height * 0.026),
                  )),
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                color: Colors.white,
                height: _height * 0.3,
                width: _width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: _height * 0.02,
                            right: _height * 0.02,
                            top: _height * 0.01,
                            bottom: _height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'จาก',
                              style: TextStyle(fontSize: _height * 0.023),
                            ),
                            _buildFormData(context),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Text(
                              'ถึง',
                              style: TextStyle(fontSize: _height * 0.023),
                            ),
                            _buildToData(context)
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                  padding: EdgeInsets.only(left: _height * 0.02),
                  child: Text(
                    'ยอดโอนเงิน',
                    style: TextStyle(fontSize: _height * 0.026),
                  )),
              _buildAmount(context),
              SizedBox(
                height: _height * 0.001,
              ),
              _buildFee(context),
              SizedBox(
                height: _height * 0.02,
              ),
              _buildNote(context),
              SizedBox(
                height: _height * 0.02,
              ),
              _buildButtonConfirm(context),
              SizedBox(
                height: _height * 0.008,
              ),
              _buildButtonCancle(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        
        title: Text(
          'รายการ: '+'1234567890',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
   Widget _buildFormData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: Colors.red,
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assests/images/SCB-logo.png'),
            radius: _height * 0.025,
          ),
          title: Text(
            'บัญชีออมทรัพย์',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          subtitle: Text(
            '123-1-1234-1',
            style: TextStyle(fontSize: _height * 0.02),
          ),
        ),
      ),
    );
  }
  Widget _buildToData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: Colors.red,
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assests/images/SCB-logo.png'),
            radius: _height * 0.025,
          ),
          title: Text(
            'คุณตัวอย่าง' + ' ' + 'ตัวอย่าง',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          subtitle: Text(
            'ธนาคารไทยพาณิชย์' + '\n' + '111-1-1111-1',
            style: TextStyle(fontSize: _height * 0.018),
          ),
        ),
      ),
    );
  }

  Widget _buildAmount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'จำนวนเงิน: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            '9,000.00' + ' บาท',
            style: TextStyle(fontSize: _height * 0.02),
          )
        ],
      ),
    );
  }

  Widget _buildFee(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'ค่าธรรมเนียม: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            '0.00' + ' บาท',
            style: TextStyle(fontSize: _height * 0.02),
          )
        ],
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'บันทึก: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            'ทดสอบการบันทึกทดสอบการบันทึกทดสอบการบันทึกทดสอบการบันทึก',
            style: TextStyle(fontSize: _height * 0.018),
          )
        ],
      ),
    );
  }

  Widget _buildButtonConfirm(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03),
      height: _height * 0.075,
      width: _width,
      child: InkWell(
        onTap: () {
          Alert(
            context: context,
            type: AlertType.success,
            title: "คุณต้องการดำเนินการต่อใช่หรือไม่",
            buttons: [
              DialogButton(
                color: Colors.pink[300],
                child: Text(
                  "ตกลง",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      message: "คุณทำการอนุมัติรายการเรียบร้อยแล้ว",
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  );
                      Navigator.pushNamed(context, PageTo.authorizerApproveSuccessScreen);
                },
                width: 120,
              )
            ],
          ).show();
        },
        child: Card(
          elevation: 5,
          color: Colors.pink[300],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'อนุมัติ',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCancle(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03),
      height: _height * 0.075,
      width: _width,
      child: InkWell(
        onTap: () {
          Alert(
            context: context,
            type: AlertType.error,
            title: "คุณต้องการดำเนินการต่อใช่หรือไม่",
            buttons: [
              DialogButton(
                color: Colors.pink[300],
                child: Text(
                  "ตกลง",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.success(
                      message: "คุณทำการยกเลิกรายการเรียบร้อยแล้ว",
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  );
                    Navigator.pushNamed(context, PageTo.authorizerApproveNotSuccessScreen);
                },
                width: 120,
              )
            ],
          ).show();
          
        },
        child: Card(
          elevation: 5,
          color: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'ไม่อนุมัติ',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}