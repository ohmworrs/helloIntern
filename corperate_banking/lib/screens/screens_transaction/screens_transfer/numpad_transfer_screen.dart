
import 'package:corperate_banking/pageTo.dart';

import 'package:corperate_banking/widgets/numpad_widget.dart';
import 'package:flutter/material.dart';

class NumpadScreen extends StatefulWidget {
  @override
  _NumpadScreenState createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  int length = 6;

  onChange(String number){
    if (number.length == length) {
      if (number == "123456") {
        Navigator.pushNamed(context, PageTo.transferSingleScreen);

      } else {
        number = null;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => NumpadScreen(),
          ),
        );
      }
    }
    print(number);
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: _height*0.02,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: _height*0.1,
              width: _width,
              child: Image.asset('assests/images/logo_isc_medium_pink.png',scale: _height*0.001,),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'กรุณาใส่รหัส PIN',
                style: TextStyle(
                  color: Colors.black,
                    fontSize: _height*0.03,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Numpad(length: length, onChange: onChange)
          ],
        ),
      ),
    );

  }
}
