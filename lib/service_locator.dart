import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pru_project_web/bloc/home_page/home_repository.dart';
import 'package:pru_project_web/bloc/login_page/login_repository.dart';
import 'package:pru_project_web/utils/generator.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    // Register Dio and RestClient as singletons
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));

    // Register repositories as factories
    locator.registerFactory<HomeRepository>(() => HomeRepository(locator<RestClient>()));
    locator.registerFactory<LoginRepository>(() => LoginRepository(locator<RestClient>()));
  }
}
