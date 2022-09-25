import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/screens/introl_screen/intro_item.dart';
import 'package:learn_english/view/screens/introl_screen/intro_poster.dart';
import 'package:learn_english/view/widgets/container_button.dart';
import 'package:learn_english/view/widgets/indicator_item.dart';
import '../../../common/manager/share_preference_service.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    injector<LocalApp>().saveIntStorage(StringConst.keySaveCheckLogIn, 1);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(top: 30, left: 0, right: 0, child: _buildBackground(context)),
          Positioned.fill(child: _buildPageView(context)),
          Positioned(bottom: 20, left: 0, right: 0, child: _buildIndicatorSmooth()),
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        int newIndex = _pageController.page!.round();
        if (newIndex != _currentIndex) {
          setState(() {
            _currentIndex = _pageController.page!.round();
          });
        }
        return true;
      },
      child: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        allowImplicitScrolling: false,
        reverse: false,
        scrollDirection: Axis.horizontal,
        children: [
          IntroItem(
            subtitle: StringConst.introTitle1,
            image: 'assets/images/intro_0.png',
            child: const IntroFooter(),
          ),
          IntroItem(
            subtitle: StringConst.introTitle2,
            image: 'assets/images/intro_1.png',
            child: const IntroFooter(),
          ),
          IntroItem(
            subtitle: StringConst.introTitle3,
            image: 'assets/images/intro_2.png',
            child: _buildAction(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorSmooth() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(3, (index) {
          return IndicatorItem(status: index == _currentIndex);
        }),
      ),
    );
  }

  Widget _buildAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: ContainerButton(
            text: 'Khám phá ngay',
            press: () async {
              await SharedPreferencesService.setFirstTime();
              Navigator.pushReplacementNamed(context, RoutingNameConstant.letYouLogInScreen);
            }),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Image.asset(
          'assets/images/intro_bg.png',
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
