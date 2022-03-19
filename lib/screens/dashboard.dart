import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:intl/intl.dart';
import '../screens/body_fat_page.dart';
import '../screens/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bmibox = Boxes.getBmi();
    final bfbox = Boxes.getBf();

    Future _pagerefresh() async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget),
      );
    }

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: RefreshIndicator(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.health_and_safety_rounded,
                    size: 85,
                    color: Color(0xff025949),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              RichText(
                softWrap: true,
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "BMI & Body Fat Percentage ",
                      style: TextStyle(
                        color: Color(
                          0xff025949,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "Calculator",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: SfCartesianChart(
                    legend: Legend(
                      position: LegendPosition.top,
                      overflowMode: LegendItemOverflowMode.wrap,
                      title: LegendTitle(
                        alignment: ChartAlignment.center,
                        text: "BMI & BODY FAT",
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      isVisible: true,
                      borderWidth: 2,
                    ),
                    primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                        text: "Tested Date",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    primaryYAxis: CategoryAxis(
                      title: AxisTitle(
                        text: "Body Mass and Body Fat",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    series: <SplineAreaSeries>[
                      SplineAreaSeries<Bmimodel, dynamic>(
                        legendIconType: LegendIconType.circle,
                        legendItemText: "Body Mass",
                        dataSource: [
                          ...bmibox.values,
                        ],
                        xValueMapper: (Bmimodel bmiData, _) =>
                            DateFormat('MMM-ddd').format(bmiData.createdDate),
                        yValueMapper: (Bmimodel bmiData, _) =>
                            double.parse(bmiData.bmi),
                      ),
                      SplineAreaSeries<Bfmodel, dynamic>(
                        legendIconType: LegendIconType.circle,
                        legendItemText: "Body Fat",
                        dataSource: [
                          ...bfbox.values,
                        ],
                        xValueMapper: (Bfmodel bfdata, _) =>
                            DateFormat('MMM-d').format(bfdata.createdDate),
                        yValueMapper: (Bfmodel bfdata, _) =>
                            double.parse(bfdata.bf),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Column(
                children: [
                  Hero(
                    tag: "Bmi Page",
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(
                          0xff025949,
                        ),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        fixedSize: Size(size.width / 1.2, size.height / 13),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionsBuilder: (context,
                                Animation<double> animation,
                                Animation<double> secAnimation,
                                Widget child) {
                              animation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeIn,
                              );
                              return ScaleTransition(
                                alignment: Alignment.center,
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (
                              context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                            ) {
                              return const BmiPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Body Mass Index",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff025949),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fixedSize: Size(size.width / 1.2, size.height / 13),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            animation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeIn,
                            );
                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (
                            context,
                            Animation<double> animation,
                            Animation<double> secAnimation,
                          ) {
                            return const BodyFatPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Body Fat Percentage",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onRefresh: () => _pagerefresh(),
        ),
      ),
    );
  }
}
