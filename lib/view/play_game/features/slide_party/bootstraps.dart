import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_english/view/play_game/features/slide_party/cores/db/adapter_initializer.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/app_setting/app_setting_local.dart';

import 'features/playboard/repositories/playboard_local.dart';

void bootstraps(Widget app) async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Hive.initFlutter();

  // Database initialization
  AdapterIntializer.initialize();

  PlayboardLocal playboardLocal = PlayboardLocalImpl();
  await playboardLocal.init();
  AppSettingLocal appSettingLocal = AppSettingLocalImpl();
  await appSettingLocal.init();

  runApp(
    ProviderScope(
      overrides: [
        playboardLocalProvider.overrideWithValue(playboardLocal),
        appSettingLocalProvider.overrideWithValue(appSettingLocal),
      ],
      child: Portal(child: app),
    ),
  );
}
