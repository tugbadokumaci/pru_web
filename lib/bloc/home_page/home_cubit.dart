import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pru_project_web/bloc/home_page/home_repository.dart';
import 'package:pru_project_web/bloc/home_page/home_state.dart';

import '../../models/report_model.dart';
import '../../utils/resource.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repo;
  late Resource<List<ReportModel>> reportsResource;

  HomeCubit({
    required HomeRepository repo,
  })  : _repo = repo,
        super(HomeInitial());

  Future<void> getAllReports() async {
    emit(HomeLoading());

    reportsResource = await _repo.getAllReports();
    if (reportsResource.status == Status.SUCCESS) {
      emit(HomeSuccess(reportsResource: reportsResource));
      debugPrint('get services success');
    } else {
      debugPrint('Error while fetching service data');
      emit(HomeError());
    }
  }
}
