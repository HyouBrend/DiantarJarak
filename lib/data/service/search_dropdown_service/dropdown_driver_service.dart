import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DropdriveService {
  final ApiHelper apiHelper;

  DropdriveService({required this.apiHelper});

  Future<DropdownDriveModelData> getAllDrivers() async {
    try {
      final response = await apiHelper.get(
        url: APIJarakLocal.listDrivers,
      );
      final result = response.data as Map<String, dynamic>;
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<DropdownDriveModelData> getDrivers(String query) async {
    try {
      final response = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listDrivers
            : '${APIJarakLocal.getDriver}/$query',
      );
      final result = response.data as Map<String, dynamic>;
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
