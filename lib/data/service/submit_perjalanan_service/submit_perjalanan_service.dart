import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class SubmitPerjalananService {
  final ApiHelper apiHelper;

  SubmitPerjalananService({required this.apiHelper});

  Future<SubmitPerjalananModel> fetchDetailPengantaran() async {
    final response = await apiHelper.get(url: APIJarakLocal.listCustomers);
    return SubmitPerjalananModel.fromJson(response.data);
  }

  Future<String> submitPengantaran(
      SubmitPerjalananModel SubmitPengantaranModel) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.submitPengantaran,
      body: SubmitPengantaranModel.toJson(),
    );
    return response.data['message'];
  }
}
