import 'package:hive/hive.dart';
part 'bf_model.g.dart';

@HiveType(typeId: 1)
class Bfmodel extends HiveObject {
  @HiveField(1)
  late String bf;

  @HiveField(2)
  late DateTime createdDate;
}
