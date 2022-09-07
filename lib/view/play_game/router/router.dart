import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_english/view/play_game/features/choose_game/start_choose_game.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/controllers/playboard_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/screen/about_us_screen.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/controllers/single_mode_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/screens/single_mode_page.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/splash_slide_party.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import '../features/2048/screen/about_screen/about_screen.dart';
import '../features/2048/screen/game_screen/game_screen.dart';
import '../features/2048/screen/menu_screen/menu_screen.dart';
import '../features/2048/screen/splash_screen_2048/splash_screen.dart';
import '../features/choose_game/choose_game.dart';
import '../features/slide_party/features/home/screens/home_page.dart';
import '../features/slide_party/features/multiple_mode/screens/multiple_mode_page.dart';

abstract class RoutesGame {
  static final routes = <String, WidgetBuilder>{
    RoutingNameGame.chooseGame: (BuildContext context) => const ChooseGame(),
    RoutingNameGame.startChooseGame: (BuildContext context) => const StartChooseGame(),
    RoutingNameGame.splash2048: (BuildContext context) => const SplashScreen2048(),
    RoutingNameGame.gameScreen: (BuildContext context) => const GameScreen(),
    RoutingNameGame.menu: (BuildContext context) => const MenuScreen(),
    RoutingNameGame.aboutUs: (BuildContext context) => const AboutScreen(),
    RoutingNameGame.homePageSlideParty: (BuildContext context) => const HomePageSlideParty(),
    RoutingNameGame.aboutUsSlideParty: (BuildContext context) => const AboutUsScreen(),
    RoutingNameGame.splashSlideParty: (BuildContext context) => SplashScreenSlideParty(),
    RoutingNameGame.mMode: (BuildContext context) => ProviderScope(
        overrides: [playboardControllerProvider.overrideWithProvider(multipleModeControllerProvider)],
        child: const MultipleModePage()),
    RoutingNameGame.sMode: (BuildContext context) => ProviderScope(
          overrides: [playboardControllerProvider.overrideWithProvider(singleModeControllerProvider)],
          child: const SingleModePage(),
        ),
  };
}
