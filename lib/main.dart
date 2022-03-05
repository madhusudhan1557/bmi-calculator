import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:bmicalculator/screens/bmi_list.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../screens/body_fat_page.dart';
import '../screens/dashboard.dart';
import './screens/bmi_page.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();

  Hive.registerAdapter(BmimodelAdapter());

  Hive.registerAdapter(BfmodelAdapter());

  await Hive.openBox<Bmimodel>('bmimodel');

  await Hive.openBox<Bfmodel>('bfmodel');

  runApp(BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      title: "Bmi Calculator",
      theme: ThemeData(
        primaryColor: const Color(0xffF2F2F2),
        backgroundColor: const Color(0xffC4D4F2),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      routes: {
        "/": (ctx) => const Dashboard(),
        BmiPage.routeName: (ctx) => const BmiPage(),
        BodyFatPage.routeName: (ctx) => const BodyFatPage(),
        BmiList.routeName: (ctx) => BmiList(),
      },
    );
  }
}
