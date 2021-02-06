import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';

class HistoryCheckerScreen extends StatefulWidget {
  @override
  _HistoryCheckerScreenState createState() => _HistoryCheckerScreenState();
}

class _HistoryCheckerScreenState extends State<HistoryCheckerScreen> {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(

        appBar: _buildAppBar(context),
        body: Container(
          padding: EdgeInsets.only(right: _height*0.01, left: _height*0.01, top: _height*0.02),
          height: _height,
          width: _width,
          child: buildHistoryCheckOrder(context, _height),
        ),

      ),
      
    );
  }
  Widget _buildAppBar(
    BuildContext context,
  ) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
      
      backgroundColor: Colors.pink[300],
      centerTitle: true,
      title: Text(
        'ประวัติการตรวจสอบ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget buildHistoryCheckOrder(BuildContext context, double _height) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, int index) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageTo.checkerHistoryOrderScreen);
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  backgroundImage:
                      AssetImage('assests/images/logo_isc_medium_orange.png'),
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
            Divider(height: _height*0.01,)
          ],
        );
      },
    );
  }
}