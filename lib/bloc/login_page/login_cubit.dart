import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pru_project_web/bloc/login_page/login_repository.dart';
import 'package:pru_project_web/bloc/login_page/login_state.dart';
import 'package:pru_project_web/constants/constants.dart';
import 'package:pru_project_web/shared_preferences_service.dart';
import 'package:pru_project_web/utils/utils.dart';

import '../../models/user_model.dart';
import '../../utils/resource.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repo;
  late Resource<UserModel> userResource;

  LoginCubit({
    required LoginRepository repo,
  })  : _repo = repo,
        super(LoginInitial());

  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();

  Future<void> initialize() async {
    getEmailController.text = await SharedPreferencesService.getEmailPreference();
    getPasswordController.text = await SharedPreferencesService.getPasswordPreference();
  }

  Future<void> login(BuildContext context) async {
    if (!EmailValidator.validate(getEmailController.text)) {
      Fluttertoast.showToast(
        msg: 'Emailiniz boş veya geçersiz olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else if (getPasswordController.text == '') {
      Fluttertoast.showToast(
        msg: 'şifre alanı boş olamaz',
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.TOP,
      );
    } else {
      emit(LoginLoading());
      final email = getEmailController.text;
      final password = getPasswordController.text;

      Resource<UserModel> resource = await _repo.login(email, password);

      if (resource.status == Status.SUCCESS) {
        Constants.USER = resource.data!;
        await SharedPreferencesService.setStringPreference(email, password);

        Fluttertoast.showToast(
          msg: 'Giriş Başarılı',
          backgroundColor: Colors.green,
          gravity: ToastGravity.TOP,
        );
        emit(LoginSuccess());
        // Navigator.pushNamed(context, '/home');
      } else if (resource.statusCode == 403) {
        // inactive account error

        Utils.showCustomDialog(
          // context: context,
          title: 'Doğrulanmamış hesap',
          content: 'Email doğrulamaya yönlendiriliyorsunuz',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/validation', arguments: {'email': email, 'password': password});
          },
        );
      } else {
        Utils.showCustomDialog(
          // context: context,
          title: 'Giriş Başarısız',
          content: resource.errorMessage ?? '',
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/logIn');
          },
        );
      }
    }
  }
}
