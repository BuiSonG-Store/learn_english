import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/router/navigate_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> init(Box box) async {
  _configureUseCases();
  _configureRepositories();
  await _initCommon(box);
}


void _configureUseCases() {

  // injector.registerFactory(() => OldShareItemCubit(
  //   injector(),
  //   injector(),
  // ));
}
void _configureRepositories() {
  // injector.registerFactory<OldAllReceiverRepository>(
  //         () => OldAllReceiverRepositoryImpl(
  //       injector(),
  //       injector(),
  //     ));
}

Future _initCommon(Box box) async {
  final prefs = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => LocalApp(box, prefs));
  injector.registerLazySingleton(() => NavigationService());
  injector.registerLazySingleton(() => AppClient());
}
