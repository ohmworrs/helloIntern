import 'package:backdrop/backdrop.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:pie_chart/pie_chart.dart';

class AuthorizerHomeScreen extends StatefulWidget {
  @override
  _AuthorizerHomeScreenState createState() => _AuthorizerHomeScreenState();
}

class _AuthorizerHomeScreenState extends State<AuthorizerHomeScreen> {
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  Future<Map<String,double>>getGraph()async{
    Map<String,double>getGraph={
    "บัญชีออมทรัพย์":1000000,
    "บัญชีกระแสรายวัน":2000000,
    "บัญชีเงินฝากประจำ":3000000
  };
    return getGraph;
  }
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BackdropScaffold(
        appBar: _buildBackdropAppBar(context),
        headerHeight: _height * 0.62,
        frontLayer: Stack(
          children: <Widget>[
            Container(
                height: _height,
                width: _width,
                child: Image.asset('assests/images/pink-geometric.jpg',fit: BoxFit.cover,),
              ),
            Container(
                // alignment: FractionalOffset.bottomLeft,
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    bottom: _height * 0.06,
                    top: _height * 0.01),
                height: _height,
                width: _width,
                // decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [Colors.white, Color(0xFFCFCFCF)])),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildMenu(context,"รายการรออนุมัติ"),
                          _buildMenu(context, "ประวัติการอนุมัติ"),
                          _buildMenu(context, "การตั้งค่า")
                        ],
                      ),
                      Card(
                        color: Colors.pink[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 10,
                        child: Container(
                          width: _width,
                          height: _height * 0.025,
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.only(
                  left: _height * 0.02,
                  right: _height * 0.02,
                  top: _height * 0.02),
              height: _height,
              width: _width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ยอดรวมสินทรัพย์',
                    style: TextStyle(
                        fontSize: _height * 0.028, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '1,000,000.00' + ' บาท',
                    style: TextStyle(
                        fontSize: _height * 0.023, fontWeight: FontWeight.w500),
                  ),
                  Container(
                padding: EdgeInsets.only(
                  left: _height * 0.02,
                  right: _height * 0.02,
                  // top: _height * 0.01,
                  // bottom: _height * 0.01,
                ),
                height: _height * 0.23,
                width: _width,
                child: FutureBuilder<Map<String, double>>(
                  future: getGraph(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var graph = snapshot.data;

                      return PieChart(
                        dataMap: graph,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: _height * 0.05,
                        chartRadius: _height * 0.15,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: _height * 0.05,
                        centerText: "",
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                              fontFamily: 'ThaiSansNeue',
                              fontSize: _height * 0.023),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                        ),
                      );
                    }
                  },
                ),
              ),
                ],
              ),
            )
          ],
        ),
        backLayer: Stack(
          children: <Widget>[
            Container(
              width: _width,
              height: _height * 0.24,
              child: Image.asset(
                'assests/images/pink-geometric.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
                width: _width,
                height: _height * 0.24,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: _height * 0.009,
                      color: Colors.pink[300],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.04,
                          right: _height * 0.02,
                          top: _height * 0.01,
                          bottom: _height * 0.01),
                      width: _width,
                      height: _height * 0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildCirclrImageProfile(context),
                          _buildHeaderDataProfile(context)
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildBackdropAppBar(
    BuildContext context,
  ) {
    final double _height = MediaQuery.of(context).size.height;
    return BackdropAppBar(
      actions: [Icon(Icons.logout)],
      backgroundColor: Colors.pink[300],
      centerTitle: true,
      title: Text(
        'Corporate Mobile Banking',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildCirclrImageProfile(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width * 0.25,
      child: CircleAvatar(
        radius: _height * 0.05,
        backgroundImage: AssetImage('assests/images/avatar-circle.png'),
      ),
    );
  }

  Widget _buildHeaderDataProfile(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: _height * 0.01),
        alignment: Alignment.centerLeft,
        height: _height,
        width: _width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.01,
            ),
            Text(
              'คุณ' + globals.staffFname+ ' ' + globals.staffLname,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'อีเมลล์: ' + globals.staffEmail,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'เบอร์โทรศัพท์: ' + globals.staffMobile,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'สถานะ: ' + globals.staffThem,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'วันเวลาที่ใช้งานล่าสุด: ' + '',
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, String menuName) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        checkNavigator(context, menuName);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          width: _width * 0.25,
          height: _height * 0.11,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.02,
              ),
              checkIcon(context, menuName),
              Text(
                menuName,
                style: TextStyle(fontSize: _height * 0.02),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkIcon(BuildContext context, String menuName) {
    final double _height = MediaQuery.of(context).size.height;
    switch (menuName) {
      case "รายการรออนุมัติ":
        return Icon(
          Icons.assignment,
          color: Colors.pink[300],
          size: _height * 0.05,
        );
        break;
      case "ประวัติการอนุมัติ":
        return Icon(
          Icons.history,
          color: Colors.pink[300],
          size: _height * 0.05,
        );
        break;
      case "การตั้งค่า":
        return Icon(
          Icons.settings,
          color: Colors.pink[300],
          size: _height * 0.05,
        );
        break;

      default:
    }
  }

  checkNavigator(BuildContext context, String menuName) {
   
    switch (menuName) {
      case "รายการรออนุมัติ":
        return Navigator.pushNamed(context, PageTo.authorizerApproveOrderScreen);
        break;
      case "ประวัติการอนุมัติ":
        return Navigator.pushNamed(context, PageTo.authorizerHistoryScreen);
        break;
      case "การตั้งค่า":
        return Navigator.pushNamed(context, PageTo.authorizerSettingScreen);
        break;

      default:
    }
  }

  

  
}
