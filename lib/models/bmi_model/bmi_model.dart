import 'package:hive/hive.dart';
part 'bmi_model.g.dart';

@HiveType(typeId: 0)
class Bmimodel extends HiveObject {
  @HiveField(1)
  late String bmi;

  @HiveField(2)
  late DateTime createdDate;
}
