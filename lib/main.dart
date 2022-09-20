import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:learn_english/common/global_app_cache/global_app_cache.dart';
import 'package:learn_english/provider/course_details_provider.dart';
import 'package:learn_english/provider/create_account_provider.dart';
import 'package:learn_english/provider/exercise_provider.dart';
import 'package:learn_english/provider/home_provider.dart';
import 'package:learn_english/provider/loading_provider.dart';
import 'package:learn_english/provider/log_in_provider.dart';
import 'package:learn_english/provider/rank_provider.dart';
import 'package:learn_english/provider/theme_provider.dart';
import 'package:learn_english/router/navigate_service.dart';
import 'package:learn_english/router/router.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/injector/injector_container.dart' as di;
import 'package:learn_english/view/play_game/features/slide_party/bootstraps.dart';
import 'package:learn_english/view/play_game/plugin/locator.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/widgets/loading/loading_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Box box = await Hive.openBox('learningBox');
  GlobalAppCache.instance.box = box;
  await initInjector();
  var isDarkTheme;
  SharedPreferences.getInstance().then((prefs) {
    isDarkTheme = prefs.getBool("darkTheme") ?? false;
  });
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((val) {
    bootstraps(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CreateAccountProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider(isDarkTheme)),
          ChangeNotifierProvider(create: (context) => LogInProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => RankProvider()),
          ChangeNotifierProvider(create: (context) => ExerciseProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProviderGame()),
          ChangeNotifierProvider(create: (context) => CourseDetailsProvider()),
          ChangeNotifierProvider(
            create: (context) => LoadingProvider.instance,
          ),
        ],
        child: const MyApp(),
      ),
    );
  });
}

Future initInjector() async {
  if (GlobalAppCache.instance.box != null) {
    await di.init(GlobalAppCache.instance.box!);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) => MaterialApp(
          theme: theme.getTheme(),
          navigatorKey: NavigationService.instance.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'English',
          initialRoute: RoutingNameConstant.splashScreen,
          routes: RoutesConstant.routes,
          builder: (context, widget) {
            return LoadingContainer(
              child: widget ?? const SizedBox(),
            );
          }),
    );
  }
}
