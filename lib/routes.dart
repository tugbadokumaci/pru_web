import 'package:flutter/material.dart';
import 'package:pru_project_web/bloc/home_page/home_cubit.dart';
import 'package:pru_project_web/bloc/home_page/home_repository.dart';
import 'package:pru_project_web/bloc/home_page/home_view.dart';
import 'package:pru_project_web/bloc/login_page/login_cubit.dart';
import 'package:pru_project_web/bloc/login_page/login_repository.dart';
import 'package:pru_project_web/bloc/login_page/login_view.dart';
import 'package:pru_project_web/constants/constants.dart';
import 'package:pru_project_web/service_locator.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginView(viewModel: LoginCubit(repo: locator.get<LoginRepository>())));
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView(viewModel: HomeCubit(repo: locator.get<HomeRepository>())));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
