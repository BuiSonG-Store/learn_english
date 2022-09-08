import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/widgets/swipe_detector_widget.dart';
import 'package:learn_english/view/play_game/features/slide_party/utils/app_infos/app_infos.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../../../../router/routing-name.dart';
import '../../../widgets/dialogs/slideparty_dialog.dart';
import '../../playboard/controllers/playboard_controller.dart';
import '../controllers/single_mode_controller.dart';
import '../widgets/body_single_mode.dart';

class SingleModePage extends StatefulWidget {
  const SingleModePage({Key? key}) : super(key: key);

  @override
  State<SingleModePage> createState() => _SingleModePageState();
}

class _SingleModePageState extends State<SingleModePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: ShowCaseWidget(
          disableBarrierInteraction: true,
          builder: Builder(
            builder: (context) => HookConsumer(
              builder: (context, ref, child) {
                final focusNode = useFocusNode();
                final controller = ref.watch(playboardControllerProvider.notifier) as SingleModePlayBoardController;
                final isMounted = useIsMounted();
                final showWinDialog = useState(false);
                ref.listen<bool>(
                  playboardControllerProvider.select((state) {
                    if (state is SinglePlayboardState) {
                      return state.playboard.isSolved;
                    }
                    return false;
                  }),
                  (_, next) {
                    if (next) {
                      Future.delayed(
                        const Duration(seconds: 2, milliseconds: 100),
                        () {
                          if (isMounted()) {
                            showWinDialog.value = true;
                          }
                        },
                      );
                    }
                  },
                );

                var widget = playboard(context, controller, showWinDialog);

                if (AppInfos.screenType == ScreenTypes.mouse ||
                    AppInfos.screenType == ScreenTypes.touchscreenAndMouse) {
                  widget = RawKeyboardListener(
                    focusNode: focusNode,
                    autofocus: true,
                    onKey: (event) {
                      if (event is RawKeyDownEvent) {
                        controller.moveByKeyboard(event.logicalKey);
                      }
                    },
                    child: GestureDetector(
                      onTap: () => focusNode.requestFocus(),
                      child: widget,
                    ),
                  );
                }
                if (AppInfos.screenType == ScreenTypes.touchscreen ||
                    AppInfos.screenType == ScreenTypes.touchscreenAndMouse) {
                  widget = SwipeDetectorWidget(
                    widget: widget,
                    controller: controller,
                  );
                }

                return widget;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget playboard(
    BuildContext _context,
    SingleModePlayBoardController controller,
    ValueNotifier<bool> showWinDialog,
  ) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/backgrounds/background_play.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _playboardView(screenSize, controller, showWinDialog),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playboardView(
    Size screenSize,
    SingleModePlayBoardController controller,
    ValueNotifier<bool> showWinDialog,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final frameSize = constraints.biggest;
        final size = frameSize.shortestSide;

        if (showWinDialog.value) {
          return Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Consumer(builder: (context, ref, _) {
                bool openSetting = ref.watch(singleModeSettingProvider);
                return SlidepartyDialog(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  title: 'YOU WIN!',
                  description: 'YOU WIN, CONGRATULATIONS!',
                  content: Image.asset(
                    'assets/images/win_single.png',
                    width: double.infinity,
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        showWinDialog.value = false;
                        controller.reset();
                        openSetting = false;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          'assets/icons/reload_dialog.svg',
                          width: 40,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(RoutingNameConstant.homePageSlideParty);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          'assets/icons/close.svg',
                          width: 40,
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer(
            builder: (context, ref, child) {
              final openSetting = ref.watch(singleModeSettingProvider);
              final boardSize = ref.watch(
                playboardControllerProvider.select((state) => (state as SinglePlayboardState).playboard.size),
              );
              return Center(
                child: BodySingleMode(
                  size: size,
                  boardSize: boardSize,
                  controller: controller,
                  openSetting: openSetting,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
