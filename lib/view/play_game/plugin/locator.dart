import 'package:get_it/get_it.dart';
import 'package:learn_english/view/play_game/plugin/navigator.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
