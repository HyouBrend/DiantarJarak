import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/data/models/detail_perjalanan_model/detail_perjalanan_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';

class DetailPerjalananService {
  final ApiHelper apiHelper;

  DetailPerjalananService({required this.apiHelper});

  Future<List<DetailPerjalananModel>> fetchDetailPengantaran(
      String perjalananID) async {
    final String url = '${APIJarakLocal.detailPengantaran}/$perjalananID';

    try {
      Response response = await apiHelper.get(url: url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        data = data.map((item) {
          if (item['jam_kembali'] == "Mon, 01 Jan 1900 00:00:00 GMT" ||
              item['jam_kembali'] == "UPDATE!!") {
            item['jam_kembali'] = "Yok Di Update!!";
          }
          if (item['jam_pengiriman'] == "Mon, 01 Jan 1900 00:00:00 GMT" ||
              item['jam_pengiriman'] == "UPDATE!!") {
            item['jam_pengiriman'] = "Yok Di Update!!";
          }
          return item;
        }).toList();

        return data
            .map((item) => DetailPerjalananModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load detail pengantaran');
      }
    } catch (e) {
      print('Error fetching detail pengantaran: $e');
      rethrow;
    }
  }
}
