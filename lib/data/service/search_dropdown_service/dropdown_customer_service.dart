import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class CustomerService {
  final ApiHelper apiHelper;

  CustomerService({required this.apiHelper});

  Future<CustomerData> getAllCustomers() async {
    try {
      final response = await apiHelper.get(url: APIJarakLocal.listCustomers);
      print('Response: ${response.data}');
      return CustomerData.fromJson(response.data);
    } catch (e) {
      print('Error fetching all customers: $e');
      rethrow;
    }
  }

  Future<CustomerData> getCustomers(String query) async {
    try {
      final response = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listCustomers
            : '${APIJarakLocal.getCustomer}/$query',
      );
      print('Response: ${response.data}');
      return CustomerData.fromJson(response.data);
    } catch (e) {
      print('Error fetching customers: $e');
      rethrow;
    }
  }
}
