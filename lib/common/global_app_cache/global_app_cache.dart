import 'package:hive/hive.dart';

class GlobalAppCache {
  factory GlobalAppCache() => _instance;

  GlobalAppCache._();

  static final GlobalAppCache _instance = GlobalAppCache._();

  static GlobalAppCache get instance => _instance;

  Box? box;

}
