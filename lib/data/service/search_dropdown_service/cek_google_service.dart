import 'package:diantar_jarak/data/models/search_dropdown_model/cek_google_model.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class CekGoogleService {
  final ApiHelper apiHelper;

  CekGoogleService({required this.apiHelper});

  Future<CekGoogleResult> cekGoogle(
      List<DropdownCustomerModel> kontaks, DropdownDriveModel driver) async {
    final body = {
      'KaryawanID': driver.karyawanID,
      'Nama': driver.nama,
      'NoHP': driver.noHP,
      'Posisi': driver.posisi,
      'Kontaks': kontaks.map((k) => k.toJson()).toList(),
    };

    print('Sending request to ${APIJarakLocal.cekGoogle} with body $body');
    final response = await apiHelper.post(
      url: APIJarakLocal.cekGoogle,
      body: body,
    );
    return CekGoogleResult.fromJson(response.data);
  }
}
