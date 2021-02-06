import 'dart:ui';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CheckerCheckNotPassReasonScreen extends StatefulWidget {
  @override
  _CheckerCheckNotPassReasonScreenState createState() =>
      _CheckerCheckNotPassReasonScreenState();
}

class _CheckerCheckNotPassReasonScreenState
    extends State<CheckerCheckNotPassReasonScreen> {
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
            _buildTextFormFiledReason(context),
            Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.4,
                ),
                _buildButtonCheckedReson(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonCheckedReson(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      child: InkWell(
        onTap: (){
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ระบบได้บันทึกข้อมูลของท่านเรียบร้อย",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
               Navigator.of(context).popUntil(ModalRoute.withName(PageTo.checkerOrderScreen));
        },
              child: Card(
          elevation: 5,
          color: Colors.pink[300],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Container(
            alignment: Alignment.center,
            width: _width,
            height: _height * 0.07,
            child: Text('เรียบร้อย',style: TextStyle(fontSize: _height*0.024,color: Colors.white),),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormFiledReason(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      width: _width,
      height: _height,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.1,
          ),
          Container(
            width: _width,
            height: _height * 0.2,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: _height * 0.01),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'กรุณาบอกเหตุผลที่ไม่ผ่านการตรวจสอบ',
                        style: TextStyle(fontSize: _height * 0.023),
                      )),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _height * 0.01, right: _height * 0.01),
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                        left: _height * 0.01, right: _height * 0.01),
                    width: _width,
                    height: _height * 0.1,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.pink)),
                    child: TextFormField(
                      style: TextStyle(fontSize: _height * 0.02),
                      maxLines: 2,
                      maxLength: 50,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: _height * 0.023),
                          enabledBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: _height * 0.02),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'บอกเหตุผลได้ที่นี่'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
    final double _width = MediaQuery.of(context).size.width;
    return AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        title: Text(
          'รายการ: ' + '1234567890',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}
