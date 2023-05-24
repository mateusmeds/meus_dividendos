import 'package:hive/hive.dart';

abstract class BaseEntity extends HiveObject {
  @HiveField(0)
  int? get id => key;
}
