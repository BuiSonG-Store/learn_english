import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:learn_english/common/constants/icons_const.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/screens/chat/chat_main.dart';
import 'package:learn_english/view/screens/home/home_screen.dart';
import 'package:learn_english/view/screens/personal/personal_screen.dart';
import 'package:learn_english/view/screens/rank/rank_screen.dart';
import 'package:provider/provider.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  int _currentIndex = 0;

  List pages = const [
    HomeScreen(),
    RankScreen(),
    ChatMain(),
    PersonalScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
            SoundController.playSoundPress();
          }
          setState(() => _currentIndex = index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Image.asset(IconConst.learning, width: 30),
            title: const Text('Learn'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/icons/ranking.png', width: 30),
            title: const Text('Rank'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset('assets/icons/talking.png', width: 30),
            title: const Text('Messages'),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Image.asset(IconConst.personal, width: 30),
            title: const Text('Personal'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
