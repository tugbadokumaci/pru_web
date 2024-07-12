import 'package:pru_project_web/models/report_model.dart';

import '../../utils/resource.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Resource<List<ReportModel>> reportsResource;

  HomeSuccess({required this.reportsResource});
}

class HomeError extends HomeState {}
