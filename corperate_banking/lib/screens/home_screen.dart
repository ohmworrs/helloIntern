
import 'package:corperate_banking/model/historyOrderRequest.dart';
import 'package:corperate_banking/model/historyOrderResponse.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  checkLogoBank(String bankName) {
    switch (bankName) {
      case "SCB":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "BBL":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "KTB":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "BAY":
        return AssetImage('assests/images/BAY.png');
        break;
      case "KBANK":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "TMB":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "NBANK":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "GHB":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "GSB":
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
      child: Scaffold(
        backgroundColor: Color(0xFFCFCFCF),
        appBar: _buildAppBar(context, _height),
        body: Container(
          padding: EdgeInsets.only(left: _height*0.02, right: _height*0.02, top: _height*0.02),
          height: _height,
          width: _width,
          child: _buildHistory(context)
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        centerTitle: true,
        title: Text(
          'รายการล่าสุด',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildHistory(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, int index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            leading: CircleAvatar(),
            title: Text('โอนเงิน\n'+'111-1-1111-1',style: TextStyle(fontSize: _height*0.02,fontWeight: FontWeight.w500),),
            subtitle:Text('12 เม.ย. 2020 - 18.18 น.'),
            trailing: Text('จำนวนเงิน\n'+'90,000.00'+' บาท'),
            

          ),
        );
      },
    );
  }
}
