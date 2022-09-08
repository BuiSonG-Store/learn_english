import 'dart:io';

import 'package:flutter/services.dart';
import 'package:real_volume/real_volume.dart';
import 'package:soundpool/soundpool.dart';

class SoundController {
  static Soundpool pool = Soundpool.fromOptions(options: const SoundpoolOptions());

  static int mergeSound = -1;

  static int swipeSound = -1;

  static int clickSound = -1;

  static int clickSoundSlideParty = -1;

  static int backGrSoundSlideParty = -1;

  static RingerMode? ringerMode = RingerMode.NORMAL;

  static Future initSound() async {
    try {
      var asset = await rootBundle.load('assets/sounds/merge.wav');
      mergeSound = await pool.load(asset);
      var asset2 = await rootBundle.load('assets/sounds/swipe_sound.wav');
      swipeSound = await pool.load(asset2);
      var asset3 = await rootBundle.load('assets/sounds/press_button.wav');
      clickSound = await pool.load(asset3);
      var asset4 = await rootBundle.load('assets/sounds/win.mp3');
      backGrSoundSlideParty = await pool.load(asset4);
      var asset5 = await rootBundle.load('assets/sounds/click1.wav');
      clickSoundSlideParty = await pool.load(asset5);
      if (Platform.isIOS) {
        RealVolume.onRingerModeChanged.listen((event) {
          ringerMode = event;
        });
      }
    } catch (_) {}
  }

  static void playSoundMerge() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(mergeSound);
    } catch (_) {}
  }

  static void playSoundSwipe() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(swipeSound);
    } catch (_) {}
  }

  static void playSoundPress() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(clickSound);
    } catch (_) {}
  }

  static void playClickSoundSlideParty() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(clickSoundSlideParty);
    } catch (_) {}
  }

  static void playBackGrSoundSlideParty() async {
    try {
      if (ringerMode == RingerMode.SILENT) {
        return;
      }
      pool.play(backGrSoundSlideParty);
    } catch (_) {}
  }
}
