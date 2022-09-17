import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/play_game/features/choose_game/choose_game.dart';
import 'package:learn_english/view/screens/chat/chat_detail/chat_detail_screen.dart';
import 'package:learn_english/view/screens/chat/chat_screen/chat_screen.dart';
import 'package:learn_english/view/screens/create_account/confitm_email.dart';
import 'package:learn_english/view/screens/create_account/create_account.dart';
import 'package:learn_english/view/screens/edit_profile/edit_profile.dart';
import 'package:learn_english/view/screens/login/login_screen.dart';
import 'package:learn_english/view/screens/container_screen.dart';
import 'package:learn_english/view/screens/introl_screen/intro_screen.dart';
import 'package:learn_english/view/screens/login/let_you_login.dart';
import 'package:learn_english/view/screens/question_screen/widgets/done_question.dart';
import 'package:learn_english/view/screens/splash/splash_screen.dart';
import '../view/play_game/features/choose_game/start_choose_game.dart';
import '../view/play_game/features/slide_party/features/home/screens/home_page.dart';
import '../view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import '../view/play_game/features/slide_party/features/multiple_mode/screens/multiple_mode_page.dart';
import '../view/play_game/features/slide_party/features/playboard/controllers/playboard_controller.dart';
import '../view/play_game/features/slide_party/features/single_mode/controllers/single_mode_controller.dart';
import '../view/play_game/features/slide_party/features/single_mode/screens/single_mode_page.dart';

abstract class RoutesConstant {
  static final routes = <String, WidgetBuilder>{
    RoutingNameConstant.homeContainer: (BuildContext context) =>
        const ContainerScreen(),
    RoutingNameConstant.introScreen: (BuildContext context) =>
        const IntroScreen(),
    RoutingNameConstant.letYouLogInScreen: (BuildContext context) =>
        const LetYouLogInScreen(),
    RoutingNameConstant.createAccount: (BuildContext context) =>
        const CreateAccount(),
    RoutingNameConstant.splashScreen: (BuildContext context) =>
        const SplashScreen(),
    RoutingNameConstant.logInScreen: (BuildContext context) =>
        const LogInScreen(),
    RoutingNameConstant.confirmEmail: (BuildContext context) =>
        const ConfirmEmail(),
    RoutingNameConstant.editProfile: (BuildContext context) =>
        const EditProfile(),
    RoutingNameConstant.DoneQuestion: (BuildContext context) =>
        const DoneQuestion(),
    RoutingNameConstant.chatDetailScreen: (BuildContext context) =>
        const ChatDetailScreen(),
    RoutingNameConstant.chatScreen: (BuildContext context) =>
        const ChatScreen(),
    RoutingNameConstant.chooseGame: (BuildContext context) =>
        const ChooseGame(),
    RoutingNameConstant.startChooseGame: (BuildContext context) =>
        const StartChooseGame(),
    RoutingNameConstant.homePageSlideParty: (BuildContext context) =>
        const HomePageSlideParty(),
    RoutingNameConstant.done: (BuildContext context) => const DoneQuestion(),
    RoutingNameConstant.mMode: (BuildContext context) => ProviderScope(
            overrides: [
              playboardControllerProvider
                  .overrideWithProvider(multipleModeControllerProvider)
            ],
            child: const MultipleModePage()),
    RoutingNameConstant.sMode: (BuildContext context) => ProviderScope(
          overrides: [
            playboardControllerProvider
                .overrideWithProvider(singleModeControllerProvider)
          ],
          child: const SingleModePage(),
        ),
  };
}
