import 'package:hive_flutter/hive_flutter.dart';

import '../../widgets/buttons/models/slideparty_button_params.dart';

class AdapterIntializer {
  static void initialize() {
    Hive.registerAdapter<ButtonColors>(ButtonColorsAdapter());
  }
}
