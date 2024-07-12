import '../../inheritance/mixin_report_feature.dart';
import '../../utils/generator.dart';

class HomeRepository with MixinReportFeature {
  RestClient client;
  HomeRepository(this.client);
}
