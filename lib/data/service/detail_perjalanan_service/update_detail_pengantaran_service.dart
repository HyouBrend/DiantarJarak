import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_pengantaran_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';

class UpdateDetailPengantaranService {
  final ApiHelper apiHelper;

  UpdateDetailPengantaranService({required this.apiHelper});

  Future<void> updateDetailPengantaran(
      UpdateDetailPengantaranModel detail) async {
    final String url = APIJarakLocal.updateDetailPengantaran;

    try {
      final response = await apiHelper.post(
        url: url,
        body: detail.toJson(),
      );

      if (response.statusCode == 200) {
        print('Update Pengantaran Berhasil!');
      } else {
        throw Exception('Failed to update pengantaran');
      }
    } catch (e) {
      print('Error updating pengantaran: $e');
      rethrow;
    }
  }
}
