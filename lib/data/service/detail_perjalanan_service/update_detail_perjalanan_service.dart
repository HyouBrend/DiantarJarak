import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_perjalanan_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class UpdateDetailPerjalananService {
  final ApiHelper apiHelper;

  UpdateDetailPerjalananService({required this.apiHelper});

  Future<void> updateDetailPerjalanan(
      UpdateDetailPerjalananModel detail) async {
    final String url = APIJarakLocal.updateDetailPerjalanan;

    try {
      Response response = await apiHelper.post(
        url: url,
        body: detail.toJson(),
      );

      if (response.statusCode == 200) {
        print('Update Perjalanan Berhasil!');
      } else {
        throw Exception('Failed to update perjalanan');
      }
    } catch (e) {
      print('Error updating perjalanan: $e');
      rethrow;
    }
  }
}
