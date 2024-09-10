import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class HistoryPerjalananService {
  final ApiHelper apiHelper;

  HistoryPerjalananService({required this.apiHelper});

  Future<HistoryPerjalananModelData> getHistoriesWithFilters({
    required String namaDriver,
    required String createdBy,
    required String status,
    required String timeline,
  }) async {
    try {
      final response = await apiHelper.post(
        url: APIJarakLocal.historyPengantaran,
        body: {
          "nama_driver": namaDriver,
          "created_by": createdBy,
          "status": status,
          "timeline": timeline,
        },
      );
      print('Response: ${response.data}');

      // Periksa dan ubah nilai default dalam response.data
      Map<String, dynamic> data = response.data;
      data['data'] = (data['data'] as List).map((item) {
        if (item['jam_kembali'] == "Mon, 01 Jan 1900 00:00:00 GMT") {
          item['jam_kembali'] = "Yok Di Update!!";
        }
        if (item['jam_pengiriman'] == "Mon, 01 Jan 1900 00:00:00 GMT") {
          item['jam_pengiriman'] = "Yok Di Update!!";
        }
        return item;
      }).toList();

      return HistoryPerjalananModelData.fromJson(data);
    } catch (e) {
      print('Error fetching history pengantaran: $e');
      rethrow;
    }
  }
}
