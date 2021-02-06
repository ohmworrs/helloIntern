import 'dart:convert';

import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/widgets/wave_widget.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/login_request.dart';
import 'package:rest_package/bean/login_response.dart';
import 'package:rest_package/connection/auth_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController companyCodeController = TextEditingController();
  TextEditingController userCodeController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  String _password;
  final _formKey = GlobalKey<FormState>();
  AuthConnection auth = AuthConnection(globals.iPV4, '8080');
  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> Login(BuildContext context) async {
    
    
    if (_formKey.currentState.validate()) {
      final double _height = MediaQuery.of(context).size.height;
      final double _width = MediaQuery.of(context).size.width;

      XSignature randReqRefNo = XSignature();

      String reqRefNo = 'REQ' + randReqRefNo.generateREQRefNo();

      print('companyCode = ' + companyCodeController.text);
      print('userCode = ' + userCodeController.text);
      print('userPassword = ' + userPasswordController.text);
      LoginRequest request = LoginRequest(
          companyCode: int.parse(companyCodeController.text),
          userCode: userCodeController.text,
          userPassword: userPasswordController.text,
          reqRefNo: reqRefNo);
      
      auth.login(request).then((value) {
        print('status code= ' + value.statusCode.toString());
        if (value.statusCode == 200) {
          //print('body= ' + value.body);
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          LoginResponse response = LoginResponse.fromJson(responseMap);
          if (reqRefNo == response.reqRefNo &&
              response.respCode == ResponseCode.APPROVED) {
            print('respCode = ' + response.respCode);
            print('login success');
            globals.staffFname = response.name_th;
            globals.staffLname = response.lastname_th;
            globals.staffEmail = response.email;
            globals.staffMobile = response.mobile_No;
            globals.staffThem = response.theme;
            globals.nameTHCompany = response.name_Th_Company;
            globals.token = response.token;
            print('staff FName: ' + globals.staffFname);
            print('staff LName: ' + globals.staffLname);
            print('staff Email: ' + globals.staffEmail);
            print('staff Mobile: ' + globals.staffMobile);
            print('staff theme: ' + globals.staffThem);
            print('staff nameTHCompany: ' + globals.nameTHCompany);
            print('token: ' + globals.token);
            if (response.theme == 'MAKER') {
              Navigator.pushNamed(context, PageTo.indexScreen);
            }
            if (response.theme == 'CHECKER') {
              Navigator.pushNamed(context, PageTo.checkerHomeScreen);
            }
            if (response.theme == 'AUTHORIZER') {
              Navigator.pushNamed(context, PageTo.authorizerHomeScreen);
            }
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Padding(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      child: Container(
                        alignment: Alignment.center,
                        height: _height * 0.2,
                        width: _width,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Icon(
                              Icons.sms_failed,
                              color: Colors.red,
                              size: _height * 0.08,
                            ),
                            Text(
                              'กรุณาใส่ข้อมูลให้ถูกต้อง',
                              style: TextStyle(fontSize: _height * 0.023),
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Card(
                                elevation: 5,
                                color: Colors.pink,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: _height * 0.05,
                                  width: _width,
                                  child: Text(
                                    'ตกลง',
                                    style: TextStyle(
                                        fontSize: _height * 0.02,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    child: Container(
                      alignment: Alignment.center,
                      height: _height * 0.2,
                      width: _width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          Icon(
                            Icons.sms_failed,
                            color: Colors.red,
                            size: _height * 0.08,
                          ),
                          Text(
                            'กรุณาใส่ข้อมูลให้ถูกต้อง',
                            style: TextStyle(fontSize: _height * 0.023),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                alignment: Alignment.center,
                                height: _height * 0.05,
                                width: _width,
                                child: Text(
                                  'ตกลง',
                                  style: TextStyle(
                                      fontSize: _height * 0.02,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      });
    } else {
      print('failed');
    }
    //Navigator.pushNamed(context, PageTo.authorizerHomeScreen);
    //Navigator.pushNamed(context, PageTo.checkerHomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: _width,
            height: _height,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 3.7 : 0.0,
                  child: WaveWidget(
                    size: size,
                    yOffset: size.height / 1.15,
                    color: Colors.pink[300],
                  ),
                ),
                Container(
                  width: _width,
                  height: _height,
                  padding: EdgeInsets.only(
                    left: _height * 0.015,
                    right: _height * 0.015,
                    top: _height * 0.038,
                    bottom: _height * 0.02,
                  ),
                  child: Column(
                    children: <Widget>[
                      // SizedBox(
                      //   height: _height * 0.03,
                      // ),
                      buildLogo(context, _height),
                      Container(
                        padding: EdgeInsets.only(
                            left: _height * 0.05, right: _height * 0.05),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: _height * 0.04,
                              ),
                              buildTextFormFieldCompanyCode(context, _height),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              buildTextFormFielduserCode(context, _height),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              buildTextFormFielduserPassword(context, _height),
                              SizedBox(
                                height: _height * 0.04,
                              ),
                              buildButtonSignIn(context, _height)
                            ],
                          ),
                        ),
                        width: _width,
                        height: _height * 0.55,
                      ),
                      buildContact(context, _height)
                    ],
                  ),
                )
              ],
            ),
            //
          ),
        ),
      ),
    );
  }

  Widget buildLogo(BuildContext context, double _height) {
    return Container(
      height: _height * 0.3,
      child: Image.asset(
        'assests/images/logo_isc_medium_pink.png',
        scale: _height * 0.002,
      ),
    );
  }

  Widget buildTextFormFieldCompanyCode(BuildContext context, double _height) {
    return Container(
      //padding: EdgeInsets.only(left: _height * 0.05, right: _height * 0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.pink[50]),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: companyCodeController,
        style: TextStyle(color: Colors.black, fontSize: _height * 0.023),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.apartment, color: Colors.pink,),
          contentPadding: EdgeInsets.symmetric(vertical: _height * 0.02),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25)),
          hintText: 'รหัสองค์กร',
          hintStyle: TextStyle(fontSize: _height * 0.023 //18
              ),
          errorStyle: TextStyle(fontSize: _height * 0.015),
          labelStyle: TextStyle(
            fontSize: _height * 0.02,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFielduserCode(BuildContext context, double _height) {
    return Container(
      //padding: EdgeInsets.only(left: _height * 0.05, right: _height * 0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.pink[50]),
      child: TextFormField(
        
        keyboardType: TextInputType.text,
        controller: userCodeController,
        style: TextStyle(color: Colors.black, fontSize: _height * 0.023),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle, color: Colors.pink,),
          contentPadding: EdgeInsets.symmetric(vertical: _height * 0.02),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25)),
          hintText: 'รหัสผู้ใช้',
          hintStyle: TextStyle(fontSize: _height * 0.023 //18
              ),
          errorStyle: TextStyle(fontSize: _height * 0.015),
          labelStyle: TextStyle(
            fontSize: _height * 0.02,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFielduserPassword(BuildContext context, double _height) {
    return Container(
      //padding: EdgeInsets.only(left: _height * 0.05, right: _height * 0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.pink[50]),
      child: TextFormField(
        obscureText: _obscureText,
        
        onSaved: (val)=>_password=val,
        keyboardType: TextInputType.text,
        controller: userPasswordController,
        style: TextStyle(color: Colors.black, fontSize: _height * 0.023),
        decoration: InputDecoration(
          suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_rounded,color: _obscureText?Colors.grey:Colors.black,), onPressed:()=>_toggle()),
          prefixIcon: Icon(Icons.lock,color: Colors.pink,),
          contentPadding: EdgeInsets.symmetric(vertical: _height * 0.02),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(25)),
          hintText: 'รหัสผ่าน',
          hintStyle: TextStyle(fontSize: _height * 0.023 //18
              ),
          errorStyle: TextStyle(fontSize: _height * 0.015),
          labelStyle: TextStyle(
            fontSize: _height * 0.02,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildButtonSignIn(BuildContext context, double _height) {
    return Container(
      padding: EdgeInsets.only(
          // left: _height * 0.05,
          // right: _height * 0.05,
          top: _height * 0.01,
          bottom: _height * 0.02),
      height: _height * 0.1,
      child: InkWell(
        onTap: () {
          //Login();
          Login(context);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32), color: Colors.pink),
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
                color: Colors.white,
                fontSize: _height * 0.023,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget buildContact(BuildContext context, double _height) {
    return Container(
      alignment: FractionalOffset.bottomCenter,
      height: _height * 0.07,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.phone_in_talk_rounded,
            color: Colors.white,
          ),
          Text(
            ' Call center 02-999-9999',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      ),
    );
  }
}
