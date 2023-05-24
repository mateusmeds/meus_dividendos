import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();
  }
}
