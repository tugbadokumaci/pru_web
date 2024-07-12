import 'package:flutter/rendering.dart';
import '../models/user_model.dart';

class Constants {
  Constants._();

  static UserModel USER = UserModel(
    userId: 0,
    userName: '',
    userSurname: '',
    userEmail: '',
    userPassword: '',
  );
}

const EdgeInsets kHorizontalPadding = EdgeInsets.symmetric(horizontal: 15.0);
const EdgeInsets kVerticalPadding = EdgeInsets.symmetric(vertical: 15.0);
const EdgeInsets kAllPadding = EdgeInsets.all(15.0);

const String homeRoute = '/home';
const String loginRoute = '/logIn';

class ApiConstants {
  ApiConstants._();
  // static const String BASE_URL = "https://www.codeocean.net";
  static const String BASE_URL = "http://www.pru.webyazilim.web.tr";
}

class Localization {
  static const SUPPORTED_LANGUAGES = [
    TR_LOCALE,
    EN_LOCALE,
    DE_LOCALE,
  ];

  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const DE_LOCALE = Locale("de", "DE");
  static const LANG_PATH = "assets/lang";
}
