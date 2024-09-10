import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_customer_service.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerService customerService;

  CustomerBloc({required this.customerService}) : super(CustomerInitial()) {
    on<FetchCustomers>((event, emit) async {
      emit(CustomerLoading());
      try {
        final result = await customerService.getCustomers(event.query);
        if (result.data!.isNotEmpty) {
          emit(CustomerHasData(result.data!));
        } else {
          emit(CustomerEmpty());
        }
      } catch (error) {
        emit(CustomerError(error.toString()));
      }
    });
  }
}
