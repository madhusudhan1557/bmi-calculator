import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Bmimodel> getBmi() => Hive.box<Bmimodel>('bmimodel');
  static Box<Bfmodel> getBf() => Hive.box<Bfmodel>('bfmodel');
}
