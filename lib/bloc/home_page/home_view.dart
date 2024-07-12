import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pru_project_web/bloc/home_page/home_cubit.dart';
import 'package:pru_project_web/bloc/home_page/home_state.dart';

import '../../models/report_model.dart';
import '../../size_config.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widgets/lottie_widget.dart';

class HomeView extends StatefulWidget {
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    // debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        debugPrint('Home View State is : $state');
        if (state is HomeInitial) {
          // widget.viewModel.getData();
          widget.viewModel.getAllReports();
          return Container();
        } else if (state is HomeLoading) {
          return _buildLoading();
        } else if (state is HomeSuccess) {
          return _buildSuccess(context, state);
        } else if (state is HomeError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
  }

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return ListView.builder(
      itemCount: state.reportsResource.data!.length,
      itemBuilder: (context, index) {
        ReportModel report = state.reportsResource.data![index];
        return ListTile(
          title: Text(report.reportTitle),
          subtitle: Text(report.reportDescription),
          onTap: () {
            // Navigate to report details page or perform any other action
          },
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          color: Colors.yellow,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hata ile karşılaşıldı', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
        Container(
            color: Colors.black,
            child: const Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'error_animation'),
            )),
      ],
    ));
  }
}
