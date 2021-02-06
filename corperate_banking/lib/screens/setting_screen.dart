import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/logout_request.dart';
import 'package:rest_package/bean/logout_response.dart';
import 'package:rest_package/connection/logout_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  XSignature randReqRefNo = XSignature();
  LogoutConnection logout = LogoutConnection(globals.iPV4, '8080');

  Future<void>logOut()async{
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefLogout: ' + reqRefNo);
    LogoutRequest request = LogoutRequest(reqRefNo: reqRefNo);
    await logout.connectLogout(request, globals.token).then((value){
      //print('status code Logout= ' + value.statusCode.toString());
      if (value.statusCode == 200){
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        LogoutResponse response = LogoutResponse.fromJson(responseMap);
        print('resDescLogout: '+response.respDesc);
        if (response.respCode == ResponseCode.APPROVED){
              Navigator.pop(context);
              globals.token=null;
              globals.nameTHCompany=null;
              globals.staffEmail=null;
              globals.staffFname=null;
              globals.staffLname=null;
              globals.staffMobile=null;
              globals.staffProfile=null;
              globals.staffThem=null;
              print('log out OK');
            }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, _height),
        body: Stack(
          children: <Widget>[
            _buildBackgroundImageBlur(context),
            Container(
              height: _height,
              width: _width,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildHeader(context),
                      Container(
                        width: _width,
                        alignment: Alignment.bottomRight,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: _height * 0.01, right: _height * 0.01),
                            color: Colors.white,
                            child: Text(
                              'ข้อมูลส่วนตัว',
                              style: TextStyle(
                                  fontSize: _height * 0.024,
                                  color: Colors.pink),
                            )),
                      ),
                      Container(
                        width: _width,
                        height: _height * 0.005,
                        color: Colors.white,
                      ),
                      _buildEmail(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      _buildPhone(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      _buildCompany(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      SizedBox(height: _height*0.1,),
                      _buildButtonSignOut(context)
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

  Widget _buildCompany(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.apartment,
                    size: _height * 0.03,
                    color: Colors.pink,
                  ),
                  Text(
                    'บริษัท:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.nameTHCompany,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: _height * 0.03,
                    color: Colors.pink,
                  ),
                  Text(
                    'เบอรืโทรศัพท์:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.staffMobile,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSignOut(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(_height * 0.015),
      height: _height * 0.1,
      width: _width,
      child: InkWell(
        onTap: ()=>logOut(),
          child: Container(
          alignment: Alignment.center,
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: Colors.pink[300], borderRadius: BorderRadius.circular(20)),
          child: Text(
            'ออกจากระบบ',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.026,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.mail,
                    size: _height * 0.03,
                    color: Colors.pink,
                  ),
                  Text(
                    'อีเมลล์:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.staffEmail,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: _height * 0.03, right: _height * 0.03, top: _height * 0.02),
      child: Container(
          height: _height * 0.2,
          width: _width,
          child: Column(
            children: <Widget>[
              Container(
                width: _width,
                height: _height * 0.2,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height * 0.1,
                      child: CircleAvatar(
                        radius: _height * 0.05,
                        backgroundImage:
                            AssetImage('assests/images/avatar-circle.png'),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        globals.staffFname + ' ' + globals.staffLname,
                        style: TextStyle(
                            fontSize: _height * 0.024,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'สถานะ ' + globals.staffThem,
                        style: TextStyle(
                            fontSize: _height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
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

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        leading: Container(),
        title: Text(
          'การตั้งค่า',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}
