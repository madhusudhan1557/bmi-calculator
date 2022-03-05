import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:bmicalculator/widgets/bmi_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: use_key_in_widget_constructors
class BmiList extends StatelessWidget {
  static const routeName = 'bmi-list';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ValueListenableBuilder<Box<Bmimodel>>(
            valueListenable: Boxes.getBmi().listenable(),
            builder: (context, box, _) {
              final _bmi = box.values.toList().cast<Bmimodel>();

              return buildContent(_bmi);
            },
          ),
        ),
      ),
    );
  }
}
