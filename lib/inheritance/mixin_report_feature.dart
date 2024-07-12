import '../constants/constants.dart';
import '../models/report_model.dart';
import '../models/user_model.dart';
import '../service_locator.dart';
import '../utils/generator.dart';
import '../utils/resource.dart';

mixin MixinReportFeature {
  RestClient client = locator<RestClient>();

  Future<Resource<List<ReportModel>>> getAllReports() async {
    final restClient = RestClient.create();
    var value = await restClient.getAllReports();
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }

  Future<Resource<UserModel>> login(String email, String password) async {
    final restClient = RestClient.create();
    Resource<UserModel> value = await restClient.login({"userEmail": email, "userPassword": password});
    if (value.status == Status.SUCCESS) {
      Constants.USER = value.data!;
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
