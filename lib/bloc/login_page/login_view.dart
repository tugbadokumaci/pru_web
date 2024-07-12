import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pru_project_web/bloc/login_page/login_cubit.dart';
import 'package:pru_project_web/bloc/login_page/login_state.dart';
import 'package:pru_project_web/widgets/box.dart';
import 'package:pru_project_web/widgets/custom_box.dart';
import 'package:pru_project_web/widgets/custom_button.dart';

import '../../models/report_model.dart';
import '../../size_config.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widgets/lottie_widget.dart';

class LoginView extends StatefulWidget {
  final LoginCubit viewModel;
  LoginView({super.key, required this.viewModel});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => widget.viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('Login View State is : $state');
          if (state is LoginInitial) {
            return _buildInitial(context);
          } else if (state is LoginLoading) {
            return _buildLoading();
          } else if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is LoginError) {
            return _buildError(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Piri Reis Üniversitesi Admin Giriş Paneli',
                style: CustomTextStyles2.titleLargeTextStyle(context, CustomColors.pruBlue)),
            Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
            CustomBox(
              height: 500,
              width: 500,
              color: CustomColors.bgLightGray,
              child: Column(
                children: [
                  Image(image: AssetImage('assets/images/prulogo.png'), height: 100, width: 100),
                  Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                  TextField(
                    controller: widget.viewModel.getEmailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: widget.viewModel.getPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                  Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                  CustomButton(
                    height: 40,
                    width: 250,
                    color: CustomColors.pruBlue,
                    text: 'Giriş Yap',
                    callback: () {
                      // Navigator.pushNamed(context, '/home');
                      widget.viewModel.login(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
