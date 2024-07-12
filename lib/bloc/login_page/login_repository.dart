import '../../inheritance/mixin_report_feature.dart';
import '../../utils/generator.dart';

class LoginRepository with MixinReportFeature {
  RestClient client;
  LoginRepository(this.client);
}
