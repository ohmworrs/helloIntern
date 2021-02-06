import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';

class AuthorizerApproveOrderScreen extends StatefulWidget {
  @override
  _AuthorizerApproveOrderScreenState createState() => _AuthorizerApproveOrderScreenState();
}

class _AuthorizerApproveOrderScreenState extends State<AuthorizerApproveOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFCFCFCF),
        appBar: _buildAppBar(context, _height),
         body: Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFCFCFCF), Colors.white])),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Container(
                      height: _height * 0.2,
                      width: _width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.11,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      height: _height * 0.73,
                      width: _width,
                      color: Colors.white,
                      child: Container(
                        color: Colors.white,
                        child: _buildApproveOrder(context, _height),
                      ),
                    )
                  ],
                )
              ],
            )),
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
          'รายการรออนุมัติ',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildApproveOrder(BuildContext context, double _height) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, int index) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageTo.authorizerCheckScreen);
              },
              child: ListTile(
                leading: CircleAvatar(
                  
                  backgroundImage:
                      AssetImage('assests/images/avatar-circle.png'),
                ),
                title: Text(
                  'รายการการโอนเงิน\nคุณ' + 'ตัวอย่าง' + ' ' + 'ตัวอย่าง',
                  style: TextStyle(fontSize: _height * 0.02),
                ),
                subtitle: Text(
                  'เลขที่รายการ ' + '1234567890',
                  style: TextStyle(fontSize: _height * 0.02),
                ),
                trailing: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_forward_ios,
                        size: _height * 0.02, color: Colors.pink[300]),
                    SizedBox(
                      height: _height * 0.011,
                    ),
                    Text(
                      '2 เม.ย 2563 - 18:18:10',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}